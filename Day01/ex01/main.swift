//
//  main.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

let card1 = Card(c : Color.Spade, v : Value.Ace)
let card2 = Card(c : Color.Diamond, v: Value.Two)
let card3 = Card(c : Color.Spade, v: Value.Queen)


print(card1)
print(card2)
print(card3)
card3.value = Value.Ace

print(card1 == card2)
print(card1 == card3)
