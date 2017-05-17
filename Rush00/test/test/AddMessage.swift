//
//  AddMessage.swift
//  test
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class AddMessage: UIViewController {

    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringfy(values:Dictionary<String,Any>) -> String!
    {
        return JSON(values).rawString(.utf8, options: .prettyPrinted)
        
    }
    @IBAction func onClick(_ sender: Any)
    {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/messages")!)
        request.addValue("Bearer \(ViewController.user!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
       // request.httpBody
        request.httpBody=stringfy(values: ["message":["author_id":UserViewController.userId!, "content": text.text!]]).data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, res, err in
            
            guard err == nil else
            {
                print("error = \(err!)")
                return
            }
            
            print(String.init(data: data!, encoding: .utf8))
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
