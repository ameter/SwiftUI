//
//  DetailView.swift
//  PhotoRecall
//
//  Created by Chris on 5/4/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let name: String
    let image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .navigationBarTitle(Text(name), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Name", image: nil)
    }
}
