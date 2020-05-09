//
//  CardView.swift
//  Flashzilla
//
//  Created by Chris on 5/8/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled       // closest thing to an option to detect voiceover enabled (it's not set by differentiateWithoutColor)
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero     // drag amount
    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width == 0 ? Color.white : offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            //self.feedback.notificationOccurred(.success)
                        } else {
                            //self.feedback.notificationOccurred(.error)
                        }
                        
                        // remove the card
                        withAnimation {
                            self.removal?()
                        }
                    } else {
                        //withAnimation {
                            self.offset = .zero
                        //}
                    }
            }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())  // animates when cards are released back to the stack
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
