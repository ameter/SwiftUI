//
//  ContentView.swift
//  Dicey
//
//  Created by Chris on 5/10/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Image(systemName: "cube")
                    Text("Dice")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "text.insert")
                    Text("Results")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
