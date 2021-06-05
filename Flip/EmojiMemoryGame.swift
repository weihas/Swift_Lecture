//
//  EmojiMemoryGame.swift
//  Flip
//
//  Created by WeIHa'S on 2021/6/1.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    @Published private var themeUsing: Theme<String>
    
    static var themes: [Theme<String>] = [
        Theme(themeName: "Vehical", emojiOfTheme: ["🚗","✈️","🚁","⛵️","🚌","🛻","🚜","🛴","🛵"], colorOfTheme: "red", pairOfCards: 5),
        Theme(themeName: "Music", emojiOfTheme: ["🎹","🥁","🪘","🎷","🎺","🪗","🎸","🪕","🎻"], colorOfTheme: "green"),
        Theme(themeName: "Weather", emojiOfTheme: ["☀️","🌤","🌈","☁️","🌧","❄️","⚡️","🌪","💨"], colorOfTheme: "blue"),
        Theme(themeName: "Gesture", emojiOfTheme: ["👍","👊","👈","🖐","✌️","🤝","🤜","☝️","🤌","👌","👏"], colorOfTheme: "purple"),
        Theme(themeName: "Animal", emojiOfTheme: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🦄"], colorOfTheme: "gradient",pairOfCards: Int.random(in: 4...20)),
        Theme(themeName: "BallSport", emojiOfTheme: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🥏","🎱","🏓","🏸","🏒","🏑","🥍","🏏"], colorOfTheme: "yellow")
    ]

    
    init() {
        let theme = EmojiMemoryGame.themes[Int.random(in: EmojiMemoryGame.themes.indices)]
        self.model = EmojiMemoryGame.creatMemoryGame(theme: theme)
        themeUsing = theme
        EmojiMemoryGame.themes.append(Theme(themeName: "Halloween", emojiOfTheme: ["🎃","👹","👻","💀","😈","👺","🤡","👽"], colorOfTheme: "orange"))
    }
    
    static func creatMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        MemoryGame<String>(numberOfCards: theme.pairOfCards) { pairIndex in
            theme.emojiOfTheme[pairIndex]
        }
    }
    
    
    var score: Int{
        return model.scoreGet
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    var themeName: String {
        return themeUsing.themeName
    }
    var gradient: Gradient{
        if themeUsing.colorOfTheme == "gradient" {
            return Gradient(colors: [.green,themeColor])
        }else{
            return Gradient(colors: [themeColor])
        }
    }
    
    
    var themeColor: Color {
        switch themeUsing.colorOfTheme {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "purple":
            return .purple
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "pink":
            return .pink
        default:
            return .gray
        }
    }
    
    
    
    // MARK: -Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restart() {
        let theme = EmojiMemoryGame.themes[Int.random(in: EmojiMemoryGame.themes.indices)]
        self.model = EmojiMemoryGame.creatMemoryGame(theme: theme)
        themeUsing = theme
    }
    
    
    
}
