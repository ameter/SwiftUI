//
//  ContentView.swift
//  PhotoRecall
//
//  Created by Chris on 5/3/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var photos = Photos()
    @State private var showingImportView = false
    @Environment(\.presentationMode) var presentationMode
    
    var locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            List(photos.items) { photo in
                NavigationLink(destination: DetailView(photo: photo)) {
                    if photo.image != nil {
                        Image(uiImage: photo.image!)
                        .resizable()
                        //.scaledToFit()
                            .aspectRatio(photo.image!.size, contentMode: .fit)
                        .frame(width: 50, height: 50)
                    }
                    
                    Text(photo.name)
                }
            }
            .navigationBarTitle("Photo Recall")
            .navigationBarItems(trailing: Button(action: {
                self.showingImportView = true
            }) {
                Image(systemName: "plus")
                    .padding()
            })
                .sheet(isPresented: $showingImportView) {
                    ImportView(photos: self.photos, locationFetcher: self.locationFetcher)
            }
            .onAppear() {
                self.locationFetcher.start()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
