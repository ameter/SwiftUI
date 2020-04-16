//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chris on 4/7/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    
    init(_ image: String) {
        self.image = image
    }
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule()
                .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var spinAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack() {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding()
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.spinAmount[number]), axis: (x: 0, y: 1, z: 0))
                    //.animation(.default)
                    .opacity(self.opacityAmount[number])
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation(.default) {
                spinAmount[number] += 360
            }
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That was the flag of \(countries[number])"
            score -= 1
        }
        
        fadeIncorrect()
        showingScore = true
    }
    
    func fadeIncorrect() {
        withAnimation(.default) {
            for flag in 0..<opacityAmount.count {
                if flag != correctAnswer {
                    opacityAmount[flag] = 0.25
                }
            }
        }
    }
    
    func askQuestion() {
        //spinAmount = [0.0, 0.0, 0.0]
        for flag in 0..<opacityAmount.count {
            opacityAmount[flag] = 1.0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
