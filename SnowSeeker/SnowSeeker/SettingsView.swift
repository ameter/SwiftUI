//
//  SettingsView.swift
//  SnowSeeker
//
//  Created by Chris on 5/12/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: Settings
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $settings.sortSelection, label: Text("Sort")) {
                    ForEach(Settings.sort.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                Section(header: Text("Filters")) {
                    Picker(selection: $settings.filterCountry, label: Text("Country")) {
                        ForEach(Settings.country.allCases, id: \.self) {
                            Text($0 == .any ? $0.rawValue : $0.rawValue.capitalized)
                        }
                    }
                    
                    Picker(selection: $settings.filterSize, label: Text("Size")) {
                        ForEach(Settings.size.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker(selection: $settings.filterPrice, label: Text("Price")) {
                        ForEach(Settings.price.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section() {
                    HStack {
                        Spacer()
                    
                        Button("OK") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Options", displayMode: .inline)
        }
    }
    
    init(settings: Settings) {
        self.settings = settings
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: Settings())
    }
}
