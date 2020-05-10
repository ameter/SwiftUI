//
//  MissionView.swift
//  Moonshot
//
//  Created by Chris on 4/18/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    @State private var rect: CGRect = CGRect(x: 1, y: 1, width: 1, height: 1)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        //.scaleEffect(1 - (abs(self.rect.minY - geometry.safeAreaInsets.top < 0 ? self.rect.minY - geometry.safeAreaInsets.top : 0 ) / self.rect.height), anchor: .bottom)
                        .scaleEffect(max(1 - (abs(min(self.rect.minY - geometry.safeAreaInsets.top, 0.0)) / self.rect.height), 0.3), anchor: .bottom)
                        .padding(.top)
                        .frame(width: geometry.size.width * 0.7)
//                        .background(Color.red)
                        .background(GeometryGetter(rect: self.$rect))
                        
                    
                    if self.mission.launchDate != nil {
                        Text(DateFormatter.localizedString(from: self.mission.launchDate!, dateStyle: .full, timeStyle: .none))
                    }
                    
                    Text(self.mission.description)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
//                    .onTapGesture {
//                        print("outter height: \(geometry.size.height)")
//                        print("other: \(geometry.safeAreaInsets)")
//                        print("rext: \(self.rect)")
//                        print("computed: \(1 - (abs(self.rect.minY - geometry.safeAreaInsets.top) / self.rect.height))")
//                    }
                    
                    ForEach(self.astronauts, id: \.role) { CrewMember in
                        NavigationLink(destination: AstronautView(astronaut: CrewMember.astronaut)) {
                            HStack {
                                Image(CrewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()
                                        .stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(CrewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(CrewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}
