//
//  ViewController.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class Victem
{
    var name:String
    var date:Date
    var desc:String
    
    init(name:String, date:Date, desc:String)
    {
        self.name = name
        self.date = date
        self.desc = desc
    }
    
    convenience init(name:String, date:Date)
    {
        self.init(name: name, date: date, desc: "cord attack")
    }
    
    convenience init(name:String)
    {
        self.init(name: name, date: Date(timeIntervalSinceNow: 0))
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var table: UITableView!
    
    var victems = [Victem(name:"Ion"),
                   Victem(name:"Ana", date:Date(timeIntervalSinceNow: -3000000)),
                   Victem(name:"Jhon", date:Date(timeIntervalSinceNow: 3000000),desc:"accident\n le petit")
                   ]

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view, typically from a nib.
        
        
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return victems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let victem = victems[indexPath.row]
        cell.title.text = victem.name
        cell.date.text = victem.date.description(with: Locale.current)
        cell.desc.text = victem.desc
        
       // cell.background.sizeToFit()
        return cell
    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print(12)
    }
    
}

