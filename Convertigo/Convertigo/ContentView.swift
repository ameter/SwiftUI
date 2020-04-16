//
//  ContentView.swift
//  Convertigo
//
//  Created by Chris on 4/6/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    @State private var inputUnit = 2
    @State private var outputUnit = 0
    
    let units = ["mL", "L", "cup", "pt", "gal"]
    let unitTypes = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    
    var outputValue: Double {
        
        let input = Measurement(value: Double(inputValue) ?? 0, unit: unitTypes[inputUnit])
        
        return input.converted(to: unitTypes[outputUnit]).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Input")) {
                    TextField("Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section(header: Text("Output")) {
                    Section() {
                        Text("\(outputValue, specifier: "%.2f")")
                    }
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
            }
            .navigationBarTitle("Convertigo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
