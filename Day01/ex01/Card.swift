//
//  Card.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

class Card:NSObject
{
    var color:Color
    var value:Value
    override var description: String
    {
        return "(\(value.rawValue), \(color.rawValue))"
    }
    
    init(c:Color, v: Value)
    {
        color = c
        value = v
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card
        {
            if obj.color == color && obj.value == value
            {
                return true
            }
        }
        return false
    }
}
