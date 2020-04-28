//
//  UserView.swift
//  Friendster
//
//  Created by Chris on 4/26/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct UserView: View {
//    let users: Users
    //@FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    let user: User
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Group {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Age:")
                            .font(.headline)
                        
                        Text("\(user.age)")
                    }
                    .padding()
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("Company:")
                        .font(.headline)
                        
                        Text(user.company ?? "unknown company")
                    }
                    .padding()
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("E-mail:")
                        .font(.headline)
                        
                        Text(user.email ?? "unknown email")
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Address:")
                        .font(.headline)
                        
                        Text(user.address ?? "unknown address")
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About:")
                        .font(.headline)
                        
                        Text(user.about ?? "unknown about")
                    }
                    .padding()
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("Member Since:")
                        .font(.headline)
                        
                        Text(DateFormatter.localizedString(from: user.registered ?? Date(), dateStyle: .medium, timeStyle: .none))
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tags:")
                        .font(.headline)
                        
                        Text(user.tags?.joined(separator: ", ") ?? "unknown tags")
                    }
                    .padding()
                }
                
                VStack(alignment: .center) {
                Text("Friends")
                    .padding()
                    .font(.headline)
                }
                
//                ForEach(user.friends) { friend in
//                    if (self.users.getFriend(friend: friend) != nil) {
//                        NavigationLink(friend.name, destination: UserView(users: self.users, user: self.users.getFriend(friend: friend)!))
//                            .padding()
//                    }
//                }
                
                ForEach(Array(user.friends!), id: \.self) { (friend: User) in
                    NavigationLink(friend.name ?? "unknown friend", destination: UserView(user: friend))
                    .padding()
                }
                
                Spacer()
            }
            .font(.subheadline)
        }
        .navigationBarTitle(Text(user.name ?? "unknown user"), displayMode: .inline)
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UserView(users: Users(), user: User(id: UUID(), isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: Date(), tags: ["one", "two", "three"], friends: [User.Friend(id: UUID(), name: "Bob Smith"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones"), User.Friend(id: UUID(), name: "John Jones")]))
//        }
//    }
//}
