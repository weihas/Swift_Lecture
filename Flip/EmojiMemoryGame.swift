//
//  EmojiMemoryGame.swift
//  Flip
//
//  Created by WeIHa'S on 2021/6/1.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🚗","✈️","🚁","⛵️","🚌","🛻","🚜","🛴","🛵"]
    
    static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = creatMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
}
