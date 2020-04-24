//
//  ActivityView.swift
//  TicTrack
//
//  Created by Chris on 4/22/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(activity.title)
                .font(.headline)
            Text(activity.description)
            Text("Completed \(activity.count) times.")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: Activity(title: "Ride the peloton", description: "Just do it!", count: 0))
    }
}
