//
//  DiceView.swift
//  Dicey
//
//  Created by Chris on 5/10/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI


extension View {
    func endEditing() {
        UIApplication.shared.windows.forEach { $0.endEditing(true)}
    }
}


struct DiceView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State private var results = [Int]()
    
    // Note, due to an apparent SwiftUI bug, TextFields to not currently stay in sync with their binding if they are set as a value as opposed to text, so we are making them strings and converting to ints with computed values below.
    
    // Additionally, due to a second SwiftUI bug, didSet does not currently work by default wrapped properties.  We force it to fire by setting the propery within the onEditingChanged closure of the TextFields.
    @State private var numberOfDice: String = UserDefaults.standard.string(forKey: "numberOfDice") ?? "2" {
        didSet {
            UserDefaults.standard.set(numberOfDice, forKey: "numberOfDice")
        }
    }
    
    @State private var numberOfSides: String = UserDefaults.standard.string(forKey: "numberOfSides") ?? "6" {
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
    
    @State private var useResultIcons = true
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Number of dice: ")
                        Spacer()
                        TextField("dice", text: $numberOfDice, onEditingChanged: {entered in
                            if !entered {
                                // Due to a second SwiftUI bug, didSet does not currently work by default wrapped properties.  We force it to fire by setting the propery within the onEditingChanged closure of the TextFields.
                                self.numberOfDice = self.numberOfDice.trimmingCharacters(in: .whitespaces)
                                //print(self.numberOfDice)
                            }
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Number of sides: ")
                        Spacer()
                        TextField("dice", text: $numberOfSides, onEditingChanged: {entered in
                            if !entered {
                                // Due to a second SwiftUI bug, didSet does not currently work by default wrapped properties.  We force it to fire by setting the propery within the onEditingChanged closure of the TextFields.
                                self.numberOfSides = self.numberOfSides.trimmingCharacters(in: .whitespaces)
                                //print(self.numberOfSides)
                            }
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
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
                
                if !useResultIcons {
                    Text(results.map({ String($0) }).joined(separator: ", "))
                        .font(.title)
                        //.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.primary))
                        .padding()
                } else {
                    HStack {
                        ForEach(results, id: \.self) { result in
                            Image(systemName: self.colorScheme == .dark ? "\(result).square.fill" : "\(result).square")
                                .font(.largeTitle)
                        }
                    }
                }
                
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
                .disabled(!validDice)
                .opacity(validDice ? 1 : 0.3)
            }
            .navigationBarTitle("Dicey")
            //.endEditing()
        }
        .onTapGesture { self.endEditing() }
    }
    
    func roll() {
        guard validDice else { return }
        
        simpleHaptic()
        results = []
        
        useResultIcons = diceCount <= 6 && sidesCount <= 50
        
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
