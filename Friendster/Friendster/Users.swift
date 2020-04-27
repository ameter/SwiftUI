//
//  Users.swift
//  Friendster
//
//  Created by Chris on 4/26/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import Foundation

class Users: ObservableObject {
    @Published var items = [User]()
    
    init() {
        // prepare request
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // send request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the response
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                //let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                let decodedUsers = try decoder.decode([User].self, from: data)
                // use DispatchQueue.main.async to send work back to the main thread
                // I think this is needed here because items is observed and triggers a UI update.
                DispatchQueue.main.async {
                    self.items = decodedUsers
                }
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
        
        self.items = [User]()
    }
    
    func getFriend(friend: User.Friend) -> User? {
        items.first(where: { $0.id == friend.id } )
    }
}
