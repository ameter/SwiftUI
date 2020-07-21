//
//  ContentView.swift
//  FlipModifierDemo
//
//  Created by Chris on 7/21/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var isFlipped = false
    
    var body: some View {
        Text("Front")
            .flip(when: isFlipped, axis: (0, 1, 0)) {
                Text("Back")
            }
        .onTapGesture {
            withAnimation(.linear(duration: 2)) {
                self.isFlipped.toggle()
            }
        }
        .font(.largeTitle)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
