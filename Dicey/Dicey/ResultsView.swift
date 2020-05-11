//
//  ResultsView.swift
//  Dicey
//
//  Created by Chris on 5/10/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(key: "time", ascending: false)]) var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
        List(rolls, id: \.self) { roll in
            Text("\(roll.results?.map({ String($0) }).joined(separator: ", ") ?? "Unknown result")")
        }
            .navigationBarTitle("Results", displayMode: .inline)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
