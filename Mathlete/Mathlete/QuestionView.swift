//
//  QuestionView.swift
//  Mathlete
//
//  Created by Chris on 4/15/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    @State private var currentQuestion = 0
    @State private var answer = ""
    
    //@State private var showCorrect = false
    @State private var feedback = ""
    @State private var numberCorrect = 0
    @State private var numberAnswered = 0
    
    @State private var gameOver = false
    
    var score = 100
    
    var questions: [MathQuestion]
    var endGame: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Text("\(feedback)")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Score: \(numberCorrect) of \(numberAnswered)")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Card: \(currentQuestion + 1) of \(questions.count)")
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                Text("\(questions[currentQuestion].text)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                HStack(spacing: 0) {
//                    Button( action: {
//
//                    }, label: {
//                        Image(systemName: "plus.slash.minus")
//                    })
//                        .font(.headline)
//                        .background(Color.blue)
//                        .foregroundColor(Color.white)
//                        .padding(.leading)
                    
                    TextField("Answer", text: $answer, onCommit: submitAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.decimalPad)
                }
                
                Button(action: submitAnswer,  label: { Text("Submit") })
                
                Spacer()
                
                Spacer()
                
            }
            .alert(isPresented: $gameOver) {
                Alert(title: Text("Game Over"), message: Text("You got \(numberCorrect) out of \(numberAnswered)!"), dismissButton: .default(Text("Play Again"), action: endGame))
            }
            //            if showCorrect {
            //                Image(systemName: "checkmark")
            //                    .font(.system(size: 400))
            //                    .foregroundColor(.green)
            //            }
        }
    }
    
    func submitAnswer() {
        let response = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard response.count > 0 else { return }
        
        answer = ""
        numberAnswered += 1
        
        if response == questions[currentQuestion].answer {
            //showCorrect = true
            feedback = "Correct!"
            numberCorrect += 1
        } else {
            feedback = "Wrong."
        }
        
        if currentQuestion == questions.count - 1 {
            gameOver = true
        } else {
            currentQuestion += 1
        }
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questions: [MathQuestion(terms: [2, 4], op: Operator.add)]) {
            
        }
    }
}
