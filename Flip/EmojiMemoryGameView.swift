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
            
            
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 70))]){
                    ForEach(game.cards) { card in
                        CardView(card: card,gradient: game.gradient)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
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
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let foneScale: CGFloat = 0.6
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let geme = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: geme)
            
    }
}
