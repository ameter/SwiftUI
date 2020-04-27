//
//  User.swift
//  Friendster
//
//  Created by Chris on 4/26/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friend: Codable, Identifiable {
        var id: UUID
        var name: String
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
