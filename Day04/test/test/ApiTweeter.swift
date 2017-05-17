//
//  ApiTweeter.swift
//  test
//
//  Created by Admin on 24.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

struct Tweet :CustomStringConvertible
{
    let name:String
    let text:String
    let date:String
    var description: String{
        return "\(name):\(text)"
    }
}


protocol APITwitterDelegate : class
{
    func receiveTweet(_ tweets : [Tweet])
    func errorTweet(_ error: Error)
}

class APITwitterController
{
    weak var delegate: APITwitterDelegate?
    let token:String
    
    init(token:String, delegate:APITwitterDelegate)
    {
        self.token = token
        self.delegate = delegate
    }
    
    func getTweets(_ search:String)
    {
        
        
        let q = search.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let parms = "q=\(q!)&count=100&lang=fr"
        let url = URL(string : "https://api.twitter.com/1.1/search/tweets.json?\(parms)")
        let request = NSMutableURLRequest(url:url!)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data,res,err in
            
            if err != nil
            {
                DispatchQueue.main.async {
                    self.delegate?.errorTweet(err!)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    do
                    {
                        var tweest = [Tweet]()
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        let arr=(json as! Dictionary<String,Any>)["statuses"] as! [[String:Any]]
                        for obj in arr
                        {
                            let name = (obj["user"] as! Dictionary<String,Any>)["name"] as! String
                            let text = obj["text"] as! String
                            let date = obj["created_at"] as! String
                            let tweet = Tweet(name: name, text: text, date: date)
                            tweest.append(tweet)
                            
                        }
                        self.delegate?.receiveTweet(tweest)
                    }
                    catch
                    {
                        self.delegate?.errorTweet(err!)
                    }
                }
            }
        }).resume()
        
    }
}
