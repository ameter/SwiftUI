//
//  ContentView.swift
//  Moonshot
//
//  Created by Chris on 4/18/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if (self.showingDates) {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text(mission.listCrew)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingDates.toggle()
                }) {
                    Text("Show \(self.showingDates ? "Crew" : "Dates")")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
