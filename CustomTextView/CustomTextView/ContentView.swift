//
//  ContentView.swift
//  CustomTextView
//
//  Created by Chris on 5/27/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var text = ""
    
    var body: some View {
        TextView(text: $text) {
            $0.textColor = .red
            $0.text = "hmmmm"
            // Any other setup you like
        }
        .padding(.bottom, keyboard.currentHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
