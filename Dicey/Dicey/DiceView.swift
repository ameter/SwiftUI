//
//  DiceView.swift
//  Dicey
//
//  Created by Chris on 5/10/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI


struct DiceView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var results = [Int]()
    
    @State private var numberOfDice: String = UserDefaults.standard.string(forKey: "numberOfDice") ?? "0" {
        didSet {
            UserDefaults.standard.set(numberOfDice, forKey: "numberOfDice")
        }
    }
    
    @State private var numberOfSides: String = UserDefaults.standard.string(forKey: "numberOfSides") ?? "0" {
        didSet {
            UserDefaults.standard.set(numberOfSides, forKey: "numberOfSides")
        }
    }
    
    var diceCount: Int {
        Int(self.numberOfDice) ?? 0
    }
    
    var sidesCount: Int {
        Int(self.numberOfSides) ?? 0
    }
    
    var validDice: Bool {
        diceCount > 0 && sidesCount > 0
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Number of dice: ")
                        Spacer()
                        TextField("dice", text: $numberOfDice, onEditingChanged: {entered in
                            if !entered {
                                self.numberOfDice = self.numberOfDice.trimmingCharacters(in: .whitespaces)
                                print(self.numberOfDice)
                            }
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numbersAndPunctuation)
                            .frame(width: 100)
                    }
                    
                    HStack {
                    Text("Number of sides: ")
                    Spacer()
                    TextField("dice", text: $numberOfSides, onEditingChanged: {entered in
                        if !entered {
                            self.numberOfSides = self.numberOfSides.trimmingCharacters(in: .whitespaces)
                            print(self.numberOfSides)
                        }
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 100)
                    }
                    
                    if !results.isEmpty {
                        Text("Total: \(results.reduce(0, +))")
                        .padding()
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text(results.map({ String($0) }).joined(separator: ", "))
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Button(action: roll) {
                    Text("Roll")
                        .frame(width: 100)
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 25)
                        .padding()
                }
            }
            .navigationBarTitle("Dicey")
        }
    }
    
    func roll() {
        guard validDice else { return }
        
        simpleHaptic()
        results = []
        
        for _ in 0..<diceCount {
            results.append(Int.random(in: 1...sidesCount))
        }
        save()
    }
    
    func save() {
        let roll = Roll(context: self.moc)
        roll.time = Date()
        roll.results = results
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
    }
    
    func simpleHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
