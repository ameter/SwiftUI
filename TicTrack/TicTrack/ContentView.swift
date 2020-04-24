//
//  ContentView.swift
//  TicTrack
//
//  Created by Chris on 4/22/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(destination: ActivityView(activity: activity)) {
                        Text(activity.title)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(
                    action: {
                        self.showingAddTask.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(activities: self.activities)
            }
            .onReceive(activities.$items) { items in
                // This is used as a workaround to write to UserDefaults every time the items property of the expenses class is updated.
                // This is necessary because the didSet property observer currently does NOT fire on a property with the @Published property wrapper.
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
