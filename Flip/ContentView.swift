//
//  ContentView.swift
//  Flip
//
//  Created by WeIHa'S on 2021/5/30.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(viewModel.themeName)")
                    .font(.title)
                HStack{
                    Spacer()
                    Button{
                        viewModel.restart()
                    }label: {
                        Image(systemName: "gobackward")
                            .padding()
                    }
                }
            }
            
            
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 75))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card,gradient: viewModel.gradient)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.themeColor)
            .padding(.horizontal)
            Text("score: \(viewModel.score)")
                .font(.title3)
        }
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    let gradient: Gradient
    
    
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0.1)
            }
            else {
                shape.fill(LinearGradient(gradient: gradient, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            }
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let geme = EmojiMemoryGame()
        
        ContentView(viewModel: geme)
            
    }
}
