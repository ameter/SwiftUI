//
//  Photos.swift
//  PhotoRecall
//
//  Created by Chris on 5/3/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class Photos: ObservableObject {
    @Published var items = [Photo]()
    
    init() {
        loadData()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("photos.json")
        
        do {
            let data = try Data(contentsOf: filename)
            items = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData(data: Data, filename: String) throws {
        let filename = getDocumentsDirectory().appendingPathComponent(filename)
        try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    }
    
    func addPhoto(name: String, image: UIImage, location: CLLocationCoordinate2D?) {
        do {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                let photo = Photo(name: name, latitude: location?.latitude, longitude: location?.longitude)
                items.append(photo)
                
                let jsonData = try JSONEncoder().encode(self.items)
                
                try saveData(data: jsonData, filename: "photos.json")
                try saveData(data: jpegData, filename: photo.id.uuidString)
            }
        } catch {
            print("Unable to save data.")
        }
    }
    
    func deletePhoto() {
        //TODO
    }
}
