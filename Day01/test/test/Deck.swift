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
    
    var cards = allCards
    var discards = [Card]()
    var outs = [Card]()
    
    init(_ randomize:Bool)
    {
        if (randomize)
        {
            cards.randomize()
        }
    }
    
    override var description: String
    {
        return "\(cards)"
    }
    
    func draw() -> Card?
    {
        if (cards.count < 1)
        {
            return nil
        }
        let first = cards.removeFirst()
        outs.append(first)
        return first
    }
    
    func fold(_ c:Card)
    {
        let m = outs.count - 1
        for i in 0 ... m
        {
            if (c == outs[i])
            {
                outs.remove(at: i)
                discards.append(c)
            }
        }
    }
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
	
