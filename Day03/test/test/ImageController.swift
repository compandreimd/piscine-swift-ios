//
//  ImageController.swift
//  test
//
//  Created by Admin on 21.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class ImageController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.minimumZoomScale = 0.1
        scroll.maximumZoomScale = 10.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func download(url:URL)
    {
        ImageController.download(self, url: url, action: {
            image in
            self.image.image = image
        })
    }
  
    static func download(_ who:UIViewController ,url:URL, action: @escaping (UIImage?)->Void)
    {
        //session.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil
            {
                let alert = UIAlertController(title: "error", message: "Cannot access to \(url), Keep Calm", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 who.present(alert, animated: true, completion: nil)
                let image = UIImage(named:"calm")
                action(image)
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let res = response as? HTTPURLResponse
                if ((res?.allHeaderFields["Content-Type"] as? String)!).contains("image")
                {
                    let image = UIImage(data: data!)
                    action(image)
                }
                else
                {
                    let alert = UIAlertController(title: "error", message: "Cannot access to \(url), Keep Calm", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    who.present(alert, animated: true, completion: nil)
                    let image = UIImage(named:"calm")
                    action(image)
                }
                
            }
            
        }).resume()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.image;
    }
}
