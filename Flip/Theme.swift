//
//  Theme.swift
//  Flip
//
//  Created by WeIHa'S on 2021/6/2.
//

import Foundation
import SwiftUI

struct Theme<Content> {
    var themeName: String
    var emojiOfTheme: [Content]
    var colorOfTheme: String
    var pairOfCards: Int
    
    
    
    init(themeName: String, emojiOfTheme: [Content], colorOfTheme: String, pairOfCards: Int) {
        self.themeName = themeName
        self.emojiOfTheme = emojiOfTheme.shuffled()
        self.colorOfTheme = colorOfTheme
        self.pairOfCards = min(pairOfCards,emojiOfTheme.count)
    }
    
    //extra One
    init(themeName: String, emojiOfTheme: [Content], colorOfTheme: String) {
        self.themeName = themeName
        self.emojiOfTheme = emojiOfTheme.shuffled()
        self.colorOfTheme = colorOfTheme
        self.pairOfCards = emojiOfTheme.count
    }
    

    
}
