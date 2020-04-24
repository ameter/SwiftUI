//
//  ContentView.swift
//  Mathlete
//
//  Created by Chris on 4/14/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var gameIsActive = false
    @State private var questions = [Question]()
    
    var body: some View {
        Group {
            if gameIsActive {
                QuestionView(questions: questions, endGame: endGame)
            } else {
                SettingsView(startGame: startGame)
            }
        }
    }
    
    func startGame(questions: [Question]) {
        self.questions = questions
        gameIsActive = true
    }
    
    func endGame() {
        gameIsActive = false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
