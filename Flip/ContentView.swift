//
//  ContentView.swift
//  Flip
//
//  Created by WeIHa'S on 2021/5/30.
//

import SwiftUI

struct ContentView: View {
    @State var emojis:[[String]] = [["🚗","✈️","🚁","⛵️","🚌","🛻","🚜","🛴","🛵"]
    ,["🎹","🥁","🪘","🎷","🎺","🪗","🎸","🪕","🎻"]
    ,["☀️","🌤","🌈","☁️","🌧","❄️","⚡️","🌪","💨"]]
    
    @State var emojiChoice = 0
    
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 75))]){
                    ForEach(emojis[emojiChoice][0..<Int.random(in: 4...emojis[emojiChoice].count)], id: \.self){ emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                Vehicles
                Spacer()
                Music
                Spacer()
                Weather
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)

        
    }
    
    var Vehicles: some View{
        VStack {
            Button {
                emojiChoice = 0
                emojis[emojiChoice].shuffle()
            } label: {
                Image(systemName: "car")
            }
            Text("Vehicles").font(.footnote).foregroundColor(.blue)
        }
    }
    
    var Music: some View{
        VStack {
            Button {
                emojiChoice = 1
                emojis[emojiChoice].shuffle()
            } label: {
                Image(systemName: "pianokeys")
            }
            Text("Music").font(.footnote).foregroundColor(.blue)
        }
    }
    var Weather: some View{
        VStack {
            Button {
                emojiChoice = 2
                emojis[emojiChoice].shuffle()
            } label: {
                Image(systemName: "cloud.sun")
            }
            Text("Weather").font(.footnote).foregroundColor(.blue)
        }
    }
    
}



struct CardView: View {
    var content: String
    
    @State var isFaceUp: Bool = true
    
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
