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

class Cell: UITableViewCell
{
    var id = -1
    var parent : SecondViewController!
    
    func onSwipe(_ rec: UISwipeGestureRecognizer)
    {
        SecondViewController.pins.remove(at: id)
        parent.table.reloadData()
    }
}

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    static var pins: [Pin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell
        cell.id = indexPath.row
        cell.parent = self
        cell.addGestureRecognizer(UISwipeGestureRecognizer(target: cell,
                                  action: #selector(cell.onSwipe(_:))))
        cell.textLabel?.text = SecondViewController.pins[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SecondViewController.pins.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FirstViewController.whatPinShow = indexPath.row
        let view = (self.tabBarController?.viewControllers?[0] as! UINavigationController).viewControllers[0] as! FirstViewController
        view.displayPins()
        view.me = false
        tabBarController?.selectedIndex = 0
    }

}

