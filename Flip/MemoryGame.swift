//
//  MemoryGame.swift
//  Flip
//
//  Created by WeIHa'S on 2021/6/1.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get {cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set {cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    var scoreGet: Int = 0
    private var righttime: Date = Date()
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            let nowtime = Date()
            let delta = nowtime.compare(righttime).rawValue
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    scoreGet += max(1,(5 - delta))
                }else if cards[chosenIndex].isLooked {
                    scoreGet -= min(4,(1 + delta/2))
                }
                cards[chosenIndex].isFaceUp.toggle()
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                if cards[chosenIndex].isLooked{
                    scoreGet -= 1
                }
                righttime = Date()
            }
            
            cards[chosenIndex].isLooked = true
            
        }
        
        print(card)
    }
    
    
    init(numberOfCards: Int , creatCardContent: (Int) -> CardContent) {
        cards = []
        //add numberOfPairsOfCards x 2 cards to cards array
        
        for pairIndex in 0..<numberOfCards {
            let content = creatCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2 ))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        //shuffle the cards
        cards.shuffle()
        
    }
    
    
    
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isLooked = false
        
        var content: CardContent
        let id: Int

    }
    
}



extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        }else{
            return nil
        }
    }
    
}
