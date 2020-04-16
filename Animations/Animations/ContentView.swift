//
//  ContentView.swift
//  Animations
//
//  Created by Chris on 4/12/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var animationAmount: CGFloat = 1.0
    
    // gestures 1
//    @State private var dragAmount = CGSize.zero
    
//    // gestures 2
//    var letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
    
  
    
    // transitions
    @State private var isShowingRed = false
    
    var body: some View {
//        VStack {
//            Spacer()
//
//            Button("Tap me") {
//                //self.animationAmount += 1
//            }
//            .padding(50)
//            .background(Color.pink)
//            .foregroundColor(Color.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                .stroke(Color.pink)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(
//                    Animation.easeInOut(duration: 1)
//                        .repeatForever(autoreverses: false)
//                )
//            )
//            .onAppear {
//                self.animationAmount = 2
//            }
//            //        .scaleEffect(animationAmount)
//            //.blur(radius: (animationAmount - 1) * 3)
//            //.animation(.default)
//            //.animation(.easeOut)
//            //.animation(Animation.easeInOut(duration: 2)
//            //            .delay(1))
//            //        .animation(Animation.easeInOut(duration: 2)
//    //            .repeatCount(3, autoreverses: true)
//    //        )
//    //        .animation(Animation.easeInOut(duration: 1)
//    //            .repeatForever(autoreverses: true)
//    //        )
//            //.animation(.interpolatingSpring(stiffness: 50, damping: 1))
//
//            Spacer()
//
////            Stepper("Scale amount", value: $animationAmount.animation(
////                Animation.easeInOut(duration: 1)
////                    .repeatCount(3, autoreverses: true)), in: 1...10)
////
////            Spacer()
////
////            Button("Tap Me") {
////                self.animationAmount += 1
////            }
////            .padding(40)
////            .background(Color.red)
////            .foregroundColor(.white)
////            .clipShape(Circle())
////            .scaleEffect(animationAmount)
//
//            Spacer()
//
//            Button("Tap me") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                     self.animationAmount += 90
//                }
//            }
//            .padding(50)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .rotation3DEffect(.degrees(Double(animationAmount)), axis: (x: 0, y: 1, z: 0))
//
//            Spacer()
//        }
        
//        // gestures 1
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//        .frame(width: 300, height: 200)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .offset(dragAmount)
//        .gesture(
//            DragGesture()
//                .onChanged {
//                    self.dragAmount = $0.translation
//            }
//            .onEnded { _ in
//                // explicit
//                withAnimation(.spring()) {
//                    self.dragAmount = .zero
//                }
//            }
//        )
//        // implicit
//        //.animation(.spring())
  
        
        
//        //gestures 2
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(self.letters[num]))
//                .padding(5)
//                .font(.title)
//                .background(self.enabled ? Color.blue : Color.red)
//                .offset(self.dragAmount)
//                .animation(Animation.default.delay(Double(num) / 20))
//            }
//        }
//        .gesture(
//            DragGesture()
//            .onChanged {
//                self.dragAmount = $0.translation
//            }
//            .onEnded { _ in
//                self.dragAmount = .zero
//                self.enabled.toggle()
//            }
//        )
        
        
        
        // transitions
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    // simple
//                    .transition(.scale)
                    // asymetric
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
