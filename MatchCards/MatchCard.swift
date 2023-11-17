//
//  MatchCard.swift
//  MatchCards
//
//  Created by MindMingle on 16/11/2023.
//

import Foundation

class MatchCard {
    
    private(set) var cards = [Card]()
    
    var flipCount = 0
    
    private var faceUpCardIndex: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "You need atleast 1 pair of cards")
        
        // Create cards in an order
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // shuffle all the cards
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Choosen index not in Cards")
        
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = faceUpCardIndex, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                faceUpCardIndex = index
            }
        }
        
    }
    
    
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
