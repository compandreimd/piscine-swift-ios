//
//  main.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

var deck = Deck.allCards

deck.randomize()

for card in deck
{
    print(card)
}
