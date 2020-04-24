//
//  AddTaskView.swift
//  TicTrack
//
//  Created by Chris on 4/22/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("New Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save", action: save)
            )
        }
    }
    
    func save() {
        guard !title.isEmpty && !description.isEmpty else { return }
        activities.items.append(Activity(title: title, description: description, count: 0))
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(activities: Activities())
    }
}
