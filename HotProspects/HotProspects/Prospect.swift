//
//  Prospect.swift
//  HotProspects
//
//  Created by Chris on 5/6/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people = [Prospect]()
    
    static let saveKey = "SavedData"
    
    init() {
        //if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
        
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: filename) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            //UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            try? encoded.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
