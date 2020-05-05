//
//  ContentView.swift
//  Test
//
//  Created by Chris on 5/4/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var uiImage: UIImage! = UIImage(named: "test")
    var image = Image("test_portrait")
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
            
            Image(uiImage: uiImage)
                .resizable()
                //.scaledToFill()
                .aspectRatio(uiImage.size, contentMode: .fit)
                //.frame(width: uiImage.size.width / 10, height: uiImage.size.height / 10)
        }
        .onAppear{
            self.processImage()
        }
    }
    
    func processImage() {
        print(uiImage.size.height)
        print(uiImage.size.width)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
