//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Chris on 5/11/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m")
                .layoutPriority(1)
            Spacer()
                .frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm")
                .layoutPriority(1)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
