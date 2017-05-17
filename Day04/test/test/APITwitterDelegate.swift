//
//  APITwitterDelegate.swift
//  test
//
//  Created by andreimalcoci on 4/24/17.
//  Copyright © 2017 andreimalcoci. All rights reserved.
//

import Foundation

struct Tweet:CustomStringConvertible
{
    let name:String
    let text:String
    var description: String{
        return "\(name):\(text)"
    }
}

class APITwitterDelegate
{
    
}
