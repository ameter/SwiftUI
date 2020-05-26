//
//  ContentView.swift
//  CardViewTest
//
//  Created by Chris on 5/25/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}


struct Card: Identifiable, Hashable {
    var id = UUID()
    var number: Int
}


struct CardView: View {
    
    var card: Card
    
    @State var offset = CGSize.zero
    
    var callback: (CardView, Bool) -> Void
    
    var body: some View {
        Text("\(card.number)")
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 2).stroke())
            .background(Color.blue)
            .padding()
            .animation(.default)
            .offset(self.offset)
            .onTapGesture {
                
        }
        .gesture(DragGesture()
        .onChanged { value in
            self.offset = value.translation
        }
        .onEnded { value in
            let correct = self.offset.width > 0 ? true : false
            //self.offset = .zero
            self.callback(self, correct)
            }
        )
    }
}

struct ContentView: View {
    //@State private var things = [1,2,3,4,5,6,7,8]
    @State private var offset = CGSize.zero
    
    @State private var cards = [Card(number: 1), Card(number: 2), Card(number: 3), Card(number: 4), Card(number: 5), Card(number: 6), Card(number: 7), Card(number: 8)]
    
    var body: some View {
        ZStack {
            ForEach(cards, id: \.self) { card in
                CardView(card: card) { (cardView: CardView, correct: Bool) in
                    //withAnimation(Animation.linear(duration: 1.0)) {
                        //self.things.shuffle()
                        let card = self.cards.popLast()
                        if !correct {
                            self.cards.insert(card!, at: 0)
                            cardView.offset = .zero
                        }
                    //}
                }
                .stacked(at: self.cards.firstIndex(of: card)!, in: self.cards.count)
                .allowsHitTesting(card == self.cards.last)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

