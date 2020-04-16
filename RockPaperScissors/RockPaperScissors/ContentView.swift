//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Chris on 4/9/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

enum Outcome {
    case won
    case lost
    case drew
}

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appChoice = 0
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var playerChoice = 0
    @State private var resultMsg = ""
    @State private var turn = 0
    @State private var gameOver = false
    
    var body: some View {
        VStack (spacing: 20){
            Text("Score: \(score)")
                .fixedSize(horizontal: true, vertical: true)
                .padding(.bottom, 40)
            
            
            if resultMsg != "" {
                Text("I chose \(moves[appChoice]).")
                Text("You chose \(moves[playerChoice]).")
                Text("\(resultMsg)")
                    .padding(.bottom, 40)
            }
            
            Text("Try to \(shouldWin ? "win" : "lose") the \(resultMsg == "" ? "first" : "next") round.")
            
            ForEach(0 ..< moves.count) { move in
                Button("\(self.moves[move])") {
                    self.playerChose(move)
                }
            }
            
            Spacer()
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Play Again")) {
                self.turn  = 0
                self.score = 0
                self.resultMsg = ""
                })
        }
    }
    
    func playerChose(_ move: Int) {
        playerChoice = move
        appChoice = Int.random(in: 0 ..< moves.count)
        let outcome = determineOutcome(playerChoice)
        switch outcome {
        case .won:
            if shouldWin {
                resultMsg = "Congratulations, you won!"
                score += 1
            } else {
                resultMsg = "Sorry, you won when you should have lost!"
                score -= 1
            }
        case .lost:
            if shouldWin {
                resultMsg = "Sorry, you lost when you should have won!"
                score -= 1
            } else {
                resultMsg = "Congratulations, you lost!"
                score += 1
            }
        case .drew:
            resultMsg = "It was a draw!"
        }
        shouldWin = Bool.random()
        turn += 1
        if turn == 10 {
            gameOver = true
        }
    }
    
    func determineOutcome(_ playerChoice: Int) -> Outcome {
        var dist = moves.distance(from: playerChoice, to: appChoice)
        if abs(dist) == moves.count - 1 { dist *= -1 }
        
        switch dist {
        case ..<0:
            return Outcome.won
        case 1... :
            return Outcome.lost
        default:
            return Outcome.drew
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
