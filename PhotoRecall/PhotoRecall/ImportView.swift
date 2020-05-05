//
//  ImportView.swift
//  PhotoRecall
//
//  Created by Chris on 5/3/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.windows.forEach { $0.endEditing(true)}
    }
}

struct ImportView: View {
    @ObservedObject var photos: Photos
    @State private var image: UIImage?
    @State private var name = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var locationFetcher: LocationFetcher
    
    var body: some View {
        NavigationView {
            VStack {
                if image == nil {
                    ImagePicker(image: $image)
                        .navigationBarTitle("Select an image", displayMode: .inline)
                } else {
                    ScrollView {
                        Image(uiImage: self.image!)
                            .resizable()
                            //.scaledToFit()
                            .aspectRatio(self.image!.size, contentMode: .fit)
                        
                        TextField("Image Name", text: self.$name)
                            //.padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        //                        Section {
                        //                            Button("Save") {
                        //                                self.save()
                        //                            }
                        //
                        //                            Button("Cancel") {
                        //                                self.presentationMode.wrappedValue.dismiss()
                        //                            }
                        //                        }
                        //                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    .navigationBarTitle("Enter a name", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        trailing: Button("Save", action: save)
                            .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    )
                }
            }
            .padding(.bottom, keyboard.currentHeight)
            .onTapGesture { self.endEditing() }
        }
    }
    
    func save() {
        if let image = image {
            photos.addPhoto(name: name, image: image, location: self.locationFetcher.lastKnownLocation)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView(photos: Photos(), locationFetcher: LocationFetcher())
    }
}

