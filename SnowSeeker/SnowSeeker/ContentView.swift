//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Chris on 5/11/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @ObservedObject var settings = Settings()
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        var filtered = resorts
        
        // filters
        switch settings.filterCountry {
        case .austria:
            filtered = filtered.filter { $0.country == "Austria" }
        case .us:
            filtered = filtered.filter { $0.country == "United States" }
        case .france:
            filtered = filtered.filter { $0.country == "France" }
        case .italy:
            filtered = filtered.filter { $0.country == "Italy" }
        case .canada:
            filtered = filtered.filter { $0.country == "Canada" }
        case .any:
            break
        }
        
        switch settings.filterPrice {
        case .low:
            filtered = filtered.filter { $0.price == 1 }
        case .medium:
            filtered = filtered.filter { $0.price == 2 }
        case .high:
            filtered = filtered.filter { $0.price == 3 }
        case .any:
            break
        }
        
        switch settings.filterSize {
        case .small:
            filtered = filtered.filter { $0.size == 1 }
        case .medium:
            filtered = filtered.filter { $0.size == 2 }
        case .large:
            filtered = filtered.filter { $0.size == 3 }
        case .any:
            break
        }

        // sort
        switch settings.sortSelection {
        case .alabetical:
            filtered = filtered.sorted { $0.name < $1.name }
        case .country:
            filtered = filtered.sorted { $0.country < $1.country }
        case .none:
            break
        }
        
        return filtered
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort."))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingSheet = true
                    
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .padding([.leading, .vertical])
                }
            )
            .sheet(isPresented: $showingSheet) {
                SettingsView(settings: self.settings)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    }
}
