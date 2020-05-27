//
//  ContentView.swift
//  CustomTextView
//
//  Created by Chris on 5/27/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static var test:String = ""
    static var testBinding = Binding<String>(get: { test }, set: { test = $0 } )
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enter Review Comments:")
                MultilineTextView("Type here", text: ContentView.testBinding, onCommit: {
                    print("Final text: \(ContentView.test)")
                })
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                Button(action: {
                    print("send Clicked")
                }) {
                    Text("send")
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text("SwiftUI"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
