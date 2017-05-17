//
//  UserViewController.swift
//  test
//
//  Created by andreimalcoci on 4/22/17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var bt: UIButton!
    static var userId:Int!
    
    var topic = [Any]()
    @IBOutlet weak var table: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 30
        bt.isHidden = true
        topics()
        whoIam({
            dic in
            UserViewController.userId = dic["id"] as? Int
            let img = dic["image_url"] as? String
            let name = dic["displayname"] as? String
            let wall = dic["wallet"] as? Int
            let corr = dic["correction_point"] as? Int
            self.getImg(url: URL(string: img!.replacingOccurrences(of: "/images/", with: "/users/medium_"))!)
            self.name.text = name
            self.wallet.text = "Wallet \(wall!)"
            self.points.text = "Correction Point \(corr!)"
            print(UserViewController.userId)
            self.bt.isHidden = false
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func topics()
    {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics?sort=created_at")!)
        request.addValue("Bearer \(ViewController.user!)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, res, err in
            
            guard let data=data,err == nil else
            {
                print("error = \(err!)")
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let arr = json as? [Any]
                self.topic = arr!
                self.table.reloadData()
            }
            catch
            {
                print(error.localizedDescription)
            }
        }).resume()

    }
    
    func whoIam(_ f:@escaping (Dictionary<String,Any>)->Void)
    {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/me")!)
        request.addValue("Bearer \(ViewController.user!)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, res, err in
            
            guard let data = data, err == nil else
            {
                print("error = \(err!)")
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let dic = json as? Dictionary<String, Any>
                if dic != nil
                {
                    f(dic!)
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }).resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TopicCell
        
        let data = topic[indexPath.row] as? Dictionary<String,Any>
        cell?.title.text = data?["name"]  as? String
        cell?.date.text = data?["created_at"] as? String
        cell?.author.text = (data?["author"] as? Dictionary<String,Any>)?["login"] as? String
        cell?.id = data?["id"] as! Int
        return cell!
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topic.count
    }
    
    func getImg(url:URL)
    {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(ViewController.user!)", forHTTPHeaderField: "Authorization")
        //URLSession.shared.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, req , err in
            guard err == nil
            else
            {
                print(err!)
                return
            }
            self.image.image = UIImage(data: data!)
            
            
        }).resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
