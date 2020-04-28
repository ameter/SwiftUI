//
//  ContentView.swift
//  Friendster
//
//  Created by Chris on 4/26/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var users = Users()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: UserView(user: user)) {
                    VStack {
                        Text("\(user.name ?? "unknown")")
                    }
                }
            }
            .navigationBarTitle("Friendster")
        }
        .onAppear {
            if self.users.isEmpty {
                print("CoreData User entity is empty, getting data from Internet")
                self.loadData()
            }
        }
    }
    
    func loadData() {
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
                let decodedUsers = try decoder.decode([UserData].self, from: data)
                // use DispatchQueue.main.async to send work back to the main thread
                // I think this is needed here because items is observed and triggers a UI update.
                DispatchQueue.main.async {
                    for decodedUser in decodedUsers {
                        let user = User(context: self.moc)
                        
                        user.id = decodedUser.id
                        user.isActive = decodedUser.isActive
                        user.name = decodedUser.name
                        user.age = Int16(decodedUser.age)
                        user.company = decodedUser.company
                        user.email = decodedUser.email
                        user.address = decodedUser.address
                        user.about = decodedUser.about
                        user.registered = decodedUser.registered
                        user.tags = decodedUser.tags
                    }
                    
                    try? self.moc.save()
                    
                    for decodedUser in decodedUsers {
                        if let user = self.users.first(where: { $0.id == decodedUser.id }) {
                            for decodedFriend in decodedUser.friends {
                                if let friend = self.users.first(where: { $0.id == decodedFriend.id }) {
                                    user.addToFriends(friend)
                                }
                            }
                        }
                    }
                    
                    try? self.moc.save()
                    print("Loaded \(self.users.count) users.")
                }
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
