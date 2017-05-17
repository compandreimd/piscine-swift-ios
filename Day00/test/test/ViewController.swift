//
//  ViewController.swift
//  test
//
//  Created by Admin on 17.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private var rs:Int = 0
    public var error = false
    private var last:Character = "="
    public var value:Int
    {
        get
        {
            return rs
        }
        set(val){
            rs = val
            label.text = "\(rs)"
        }
    }
    private var a:Int!
    private var la:Int!
    private var b:Int!
    private var send = false
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(rs)"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onError(_ msg:String)
    {
        error = true
        label.text = msg
    }
    
    func operation(_ c:Character)
    {
        if a != nil && b != nil
        {
            print("\(a!)\(c)\(b!)")
            switch c {
            case "+":
                let (ok, o)  = Int.addWithOverflow(a, b)
                if (o)
                {
                    value  = (a % 10) + (b % 10)
                    onError("INF")
                    return;
                }
                value = ok
                break
            case "-":
                let (ok, o)  = Int.subtractWithOverflow(a, b)
                if (o)
                {
                    onError("INF")
                    return;
                }
                value = ok
                break
            case "*":
                let (ok, o)  = Int.multiplyWithOverflow(a, b)
                if (o)
                {
                    onError("INF")
                    return;
                }
                value = ok
                break
            case "/":
                if b != 0
                {
                    value = a / b
                }
                else
                {
                    onError("DIV 0")
                }
                break
            default:
                print("What c=\"\(last)\"")
            }
        }
    }
    
    @IBAction func onDigit(_ sender: Any)
    {
        if error
        {
            return
        }
        let button = sender as! UIButton
        if send
        {
            send = false
            value = 0
        }
        let (ok, o)  = Int.multiplyWithOverflow(value, 10)
        if (o)
        {
            if value > 0
            {
                onError("INF")
            }
            return;
        }
        value = ok
        if value >= 0
        {
            value += button.tag
        }
        else
        {
            value -= button.tag
        }
    }
    @IBAction func onAC(_ sender: Any)
    {
        value = 0
        a = nil
        b = nil
        error = false
        last = "="
    }
    @IBAction func onNeg(_ sender: Any)
    {
        if error
        {
            return
        }
        value *= -1
    }

    
    @IBAction func onOp(_ sender: UIButton)
    {
        if error
        {
            return
        }
        switch sender.tag {
        case 12:
            last = "+"
        case 13:
            last = "*"
        case 15:
            last = "-"
        case 16:
            last = "/"
        default:
            last = "="
        }
        if !send
        {
            if (a == nil)
            {
                 a = value
            }
            else
            {
                onEq(sender)
            }
        }
        send = true
    }
    
    @IBAction func onEq(_ sender: Any)
    {
        if error
        {
            return
        }
        if (!send)
        {
            b = value
        }
        operation(last)
        a = value
        send = true
    }

}

