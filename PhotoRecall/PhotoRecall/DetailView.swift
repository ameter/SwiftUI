//
//  DetailView.swift
//  PhotoRecall
//
//  Created by Chris on 5/4/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo
    
    var body: some View {
        VStack {
            photo.image?
                .resizable()
                .scaledToFit()
            
            if photo.location != nil {
                MapView(location: photo.location!)
            }
            
            Spacer()
        }
        .navigationBarTitle(Text(photo.name), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: Photo(name: "blah"))
    }
}
