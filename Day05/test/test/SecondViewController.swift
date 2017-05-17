//
//  SecondViewController.swift
//  test
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

struct Pin {
    let name: String
    let title: String
    let coordinate_x: Double
    let coordinate_y: Double
    
    init(name: String, title: String, x: Double, y: Double) {
        self.name = name
        self.title = title
        self.coordinate_x = x
        self.coordinate_y = y
    }
}

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    static var pins: [Pin] = [
        Pin(name:"Test",title:"124",x:47.0382503,y:28.8221739),
         Pin(name:"Test2",title:"124",x:47,y:28),
          Pin(name:"Test3",title:"124",x:47,y:29),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = SecondViewController.pins[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SecondViewController.pins.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FirstViewController.whatPinShow = indexPath.row
        let view = self.tabBarController?.viewControllers?[0] as! FirstViewController
        view.displayPins()
        view.me = false
        tabBarController?.selectedIndex = 0
    }

}

