//
//  ViewController.swift
//  test
//
//  Created by Admin on 22.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    static var access:String!
    static var key:String!
    static var user:String!
    
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var test: UIWebView!
    
    func getAccess(f:@escaping (String!)->Void)
    {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/oauth/token")!)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&client_id=\(AppDelegate.uid)&client_secret=\(AppDelegate.secrete)".data(using: .utf8)
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
                //ViewController.access = dic?["access_token"] as? String
                
                ViewController.access  = (dic?["access_token"]) as! String
                f(ViewController.access)
            }
            catch
            {
                print(error.localizedDescription)
            }
        }).resume()

    }

    
    func getUserAccess(f:@escaping (String!)->Void)
    {
       var request = URLRequest(url: URL(string: "https://api.intra.42.fr/oauth/token")!)
        request.addValue("Bearer \(ViewController.access!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = "grant_type=authorization_code&client_id=\(AppDelegate.uid)&client_secret=\(AppDelegate.secrete)&code=\(ViewController.key!)&redirect_uri=https%3A%2F%2Fgoogle.com%3A&state=test".data(using: .utf8)
        print("Debug:grant_type=authorization_code&client_id=\(AppDelegate.uid)&client_secret=\(AppDelegate.secrete)&code=\(ViewController.key!)&redirect_uri=https%3A%2F%2Fgoogle.com%3A&state=test")
        print("Debug:Bearer \(ViewController.access!)")
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
                //ViewController.access = dic?["access_token"] as? String
                
                ViewController.user  = (dic?["access_token"]) as! String
                f(ViewController.user)
            }
            catch
            {
                print(error.localizedDescription)
            }
        }).resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAccess(f: {
            str  in
            ViewController.access = str
            let req = NSMutableURLRequest(url: NSURL(string:"https://api.intra.42.fr/oauth/authorize?client_id=\(AppDelegate.uid)&response_type=code&scope=public&redirect_uri=https%3A%2F%2Fgoogle.com%3A&state=test") as URL!)
             req.addValue("Bearer \(str)", forHTTPHeaderField: "Authorization")
             self.test.loadRequest(req as URLRequest)
        })
        go.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    static func getQueryStringParameter(url: String?, param: String) -> String? {
        if let url = url, let urlComponents = NSURLComponents(string: url), let queryItems = (urlComponents.queryItems)
        {
            return queryItems.filter({ (item) in item.name == param }).first?.value!
        }
        return nil
    }
   
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (request.url?.absoluteString.contains("https://google.com"))!
        {
            self.test.isHidden = true
            self.go.isHidden = false
            ViewController.key=ViewController.getQueryStringParameter(url: request.url?.absoluteString, param: "code")
            getUserAccess(f: {str in
           
                print("Debug:\(str)")
                
            })
            
        }
        return true
    }

}

