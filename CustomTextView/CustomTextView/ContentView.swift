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
    
    @State private var test = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enter Review Comments:")
                    .onTapGesture {
                        print(self.test)
                    }
                MultilineTextView("Type here", text: $test, onCommit: {
                    print("Final text: \(self.test)")
                })
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
            }
            .navigationBarTitle(Text("SwiftUI"))
            .padding(.bottom, keyboard.currentHeight)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
