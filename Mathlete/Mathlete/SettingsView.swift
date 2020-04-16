//
//  SettingsView.swift
//  Mathlete
//
//  Created by Chris on 4/15/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var includeAddition = true
    @State private var includeSubtraction = true
    @State private var includeMultiplication = false
    @State private var includeDivision = false
    
    @State private var term1Min = 0
    @State private var term1Max = 9
    @State private var term2Min = 0
    @State private var term2Max = 9
    
    @State private var allowNegativeAnswers = false
    
    let questionCounts = ["5", "10", "15", "All"]
    @State private var numberOfQuestions = 0
    
    var startGame: ([MathQuestion]) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Operations").font(.headline)) {
                    Toggle(isOn: $includeAddition) {
                        Text("Addition")
                    }
                    
                    Toggle(isOn: $includeSubtraction) {
                        Text("Subtraction")
                    }
                    
                    Toggle(isOn: $includeMultiplication) {
                        Text("Multiplication")
                    }
                    
                    Toggle(isOn: $includeDivision) {
                        Text("Division")
                    }
                }
                
                Section(header: Text("First term").font(.headline)) {
                    Picker("Minimum", selection: $term1Min) {
                        ForEach(0..<13) {
                            Text("\($0)")
                        }
                    }
                    
                    Picker("Maximum", selection: $term1Max) {
                        ForEach(0..<13) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("Second term").font(.headline)) {
                    Picker("Minimum", selection: $term2Min) {
                        ForEach(0..<13) {
                            Text("\($0)")
                        }
                    }
                    
                    Picker("Maximum", selection: $term2Max) {
                        ForEach(0..<13) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("Options").font(.headline)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Number of questions")
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach(0..<questionCounts.count) {
                                Text("\(self.questionCounts[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Toggle(isOn: $allowNegativeAnswers) {
                        Text("Include negative answers")
                    }
                }
            }
            .navigationBarTitle("New Game")
            .navigationBarItems(trailing: Button(action: start, label: { Text("Start") }))
        }
    }
    
    func start() {
        let questions = generateQuestions()
        startGame(questions)
    }
    
    func generateQuestions() -> [MathQuestion] {
        var questions = [MathQuestion]()
        var operators = [Operator]()
        
        if includeAddition { operators.append(Operator.add) }
        if includeSubtraction { operators.append(Operator.subtract) }
        if includeMultiplication { operators.append(Operator.multiply) }
        if includeDivision { operators.append(Operator.divide) }
        
        if questionCounts[numberOfQuestions] == "All" {
            for op in operators {
                for term1 in term1Min...term1Max {
                    for term2 in term2Min...term2Max {
                        if op == Operator.subtract && term1 < term2 && !allowNegativeAnswers { continue }
                        
                        questions.append(MathQuestion(terms: [term1, term2], op: op))
                    }
                }
            }
            
        } else {
            for _ in 0..<(Int(questionCounts[numberOfQuestions]) ?? 0) {
                let op = operators.randomElement() ?? Operator.add
                var term1 = Int.random(in: term1Min...term1Max)
                var term2 = Int.random(in: term2Min...term2Max)
                
                if op == Operator.subtract && term1 < term2 && !allowNegativeAnswers {
                    let temp = term1
                    term1 = term2
                    term2 = temp
                }
                
                questions.append(MathQuestion(terms: [term1, term2], op: op))
            }
        }
        
        return questions
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView() { questions in
            
        }
    }
}
