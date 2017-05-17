//
//  ViewController.swift
//  test
//
//  Created by Admin on 24.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    var API : APITwitterController?
    var tweets = [Tweet]()
    
    @IBOutlet weak var table: UITableView!
    
    
    var token :String?
    {
        didSet{
            API = APITwitterController(token:token!, delegate:self)
            API?.getTweets("ecole 42")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 100
        getToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getToken()
    {
        
        let req = NSMutableURLRequest(url: URL(string:"https://api.twitter.com/oauth2/token")!)
        let BEARER = "\(AppDelegate.KEY):\(AppDelegate.SECRET)".data(using: String.Encoding.utf8)?.base64EncodedString()
        req.httpMethod = "POST"
        req.setValue("Basic \(BEARER!)", forHTTPHeaderField: "Authorization")
        req.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: (req as URLRequest), completionHandler: {data,res, err in
            
            let json = try! JSONSerialization.jsonObject(with: data!, options: [])
            let dic = json as? Dictionary<String,Any>
            self.token = dic?["access_token"] as? String
        
        }).resume()
    }
    func receiveTweet(_ tweets : [Tweet])
    {
        self.tweets = tweets
        table.reloadData()
    }
    
    func errorTweet(_ error: Error)
    {
        let controller = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    @IBOutlet weak var search: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if search.text != nil
        {
            API?.getTweets(search.text!)
        }
        
        search.endEditing(true)
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        let tweet = tweets[indexPath.row]
        cell!.user.text = tweet.name
        cell!.message.text = tweet.text
        cell!.date.text = tweet.date
        return cell!
    }

}

