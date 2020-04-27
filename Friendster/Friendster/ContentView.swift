//
//  ContentView.swift
//  Friendster
//
//  Created by Chris on 4/26/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var users = Users()
    
    var body: some View {
        NavigationView {
            List(users.items) { user in
                NavigationLink(destination: UserView(users: self.users, user: user)) {
                    Text(user.name)
                }
            }
            .navigationBarTitle("Friendster")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
