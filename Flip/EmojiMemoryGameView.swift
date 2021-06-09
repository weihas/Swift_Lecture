//
//  EmojiMemoryGameView.swift
//  Flip
//
//  Created by WeIHa'S on 2021/5/30.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(game.themeName)")
                    .font(.title)
                HStack{
                    Spacer()
                    Button{
                        game.restart()
                    }label: {
                        Image(systemName: "gobackward")
                            .padding()
                    }
                }
            }
            
            AspectVGrid(items: game.cards, aspectRadio: 2/3) { card in
                if card.isMatched && !card.isFaceUp{
                    Rectangle().opacity(0)
                }else{
                    CardView(card: card,gradient: game.gradient)
                        .onTapGesture {
                            game.choose(card)
                        }
                        .padding(5)
                }
            }
            
            .foregroundColor(game.themeColor)
            .padding(.horizontal)
            Text("score: \(game.score)")
                .font(.title3)
        }
    }
}



struct CardView: View {
    let card: EmojiMemoryGame.Card
    let gradient: Gradient
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 200-90))
                    .padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched{
                    shape.opacity(0.1)
                }
                else {
                    shape.fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.foneScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let foneScale: CGFloat = 0.7
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let geme = EmojiMemoryGame()
        geme.choose(geme.cards.first!)
        return EmojiMemoryGameView(game: geme)
            
    }
}
