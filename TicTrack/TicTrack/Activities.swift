//
//  Activities.swift
//  TicTrack
//
//  Created by Chris on 4/22/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id = UUID()
    
    var title = ""
    var description = ""
    var count = 0
    
    init(title: String, description: String, count: Int) {
        self.title = title
        self.description = description
        self.count = count
    }
}


class Activities: ObservableObject {
    @Published var items: [Activity]
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try?  decoder.decode([Activity].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
