//
//  FlipApp.swift
//  Flip
//
//  Created by WeIHa'S on 2021/5/30.
//

import SwiftUI

@main
struct FlipApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
