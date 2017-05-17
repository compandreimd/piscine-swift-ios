//
//  AddController.swift
//  test
//
//  Created by Admin on 19.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    @IBOutlet weak var who: UITextField!
    @IBOutlet weak var why: UITextView!
    @IBOutlet weak var whene: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onOK(_ sender: Any) {
        
        if (who.text != "")
        {
            let c = self.navigationController?.viewControllers[0] as? ViewController
            c?.victems.append(Victem(name:who.text!, date: whene.date, desc:why.text))
            c?.table.reloadData()
        }
        
       
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
        
    }
   
}
