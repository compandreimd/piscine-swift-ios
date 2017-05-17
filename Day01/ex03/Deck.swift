//
//  Deck.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

class Deck:NSObject
{
    static let allSpades:[Card] = Value.allValues.map{Card.init(c: Color.Spade, v: $0)}
    static let allClubs:[Card] = Value.allValues.map{Card.init(c: Color.Club, v: $0)}
    static let allHearts:[Card] = Value.allValues.map{Card.init(c: Color.Heart, v: $0)}
    static let allDiamonds:[Card] = Value.allValues.map{Card.init(c: Color.Diamond, v: $0)}
    static let allCards:[Card] = allSpades + allClubs + allHearts + allDiamonds
}

extension Array
{
    mutating func randomize()
    {
        for i in startIndex ..< endIndex - 1
        {
            let j = Int(arc4random_uniform(UInt32(endIndex - 1)))
            if (i != j)
            {
                swap(&self[i], &self[j])
            }
        }
    }
}
	
