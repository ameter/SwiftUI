//
//  ContentView.swift
//  BetterRest
//
//  Created by Chris on 4/10/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = ContentView.defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                //                VStack(alignment: .leading, spacing: 0) {
                //                    Text("When do you want to wake up?")
                //                        .font(.headline)
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                //                VStack(alignment: .leading, spacing: 0) {
                //                    Text("Desired amount of sleep")
                //                        .font(.headline)
                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                //                VStack(alignment: .leading, spacing: 0) {
                //                    Text("Daily coffee intake")
                //                        .font(.headline)
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    //                    Stepper(value: $coffeeAmount, in: 1...20) {
                    //                        Text("\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups")")
                    //                    }
                    Picker("Coffee intake", selection: $coffeeAmount) {
                        ForEach(0..<21) { cups in
                            Text("\(cups == 0 ? "None" : "\(cups) \(cups == 1 ? "cup" : "cups")")")
                        }
                    }
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your ideal bedtime is...")
                        .font(.headline)
                    Text("\(bedtime)")
                        .font(.largeTitle)
                    
                }
            }
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing:
//                Button(action: calculateBedtime) {
//                    Text("Calculate")
//                }
//            )
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    var bedtime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            
            return "Sorry, an error occured."
        }
    }
    
    //    func calculateBedtime() {
    //        let model = SleepCalculator()
    //
    //        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    //        let hour = (components.hour ?? 0) * 60 * 60
    //        let minute = (components.minute ?? 0) * 60
    //
    //        do {
    //            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
    //
    //            let sleepTime = wakeUp - prediction.actualSleep
    //
    //            let formatter = DateFormatter()
    //            formatter.timeStyle = .short
    //
    //            alertMessage = formatter.string(from: sleepTime)
    //            alertTitle = "Your ideal bedtime is..."
    //        } catch {
    //            alertTitle = "Error"
    //            alertMessage = "Sorry, there was a problem calculating your bedtime."
    //        }
    //
    //        showingAlert = true
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
