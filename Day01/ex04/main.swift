//
//  main.swift
//  test
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import Foundation

var newDeck: Deck = Deck(false)
newDeck.cards = Deck.allHearts
newDeck.cards.randomize()
print(newDeck)
let card = newDeck.draw()
let card2 = newDeck.draw()

print(card!)
print(card2!)

newDeck.fold(card2!)
print(newDeck)
print(newDeck.outs)
print(newDeck.discards)
