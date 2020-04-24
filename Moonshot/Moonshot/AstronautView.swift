//
//  AstronautView.swift
//  Moonshot
//
//  Created by Chris on 4/18/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let astroMissions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    ForEach(self.astroMissions) { mission in
                        Text("\(mission.displayName)")
                            .font(.headline)
                            .padding(.top)
                    }
                    
                    Text(self.astronaut.description)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        var matches = [Mission]()
        for mission in allMissions {
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        
        astroMissions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[13])
    }
}
