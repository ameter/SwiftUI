//
//  Photo.swift
//  PhotoRecall
//
//  Created by Chris on 5/3/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation

struct Photo: Codable, Identifiable, Comparable {
    var id = UUID()
    var name: String
    
    var latitude: Double?
    var longitude: Double?
    
    var location: CLLocationCoordinate2D? {
        if let latitude = latitude, let longitude = longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    var image: UIImage? {
        let filename = documentsDirectory.appendingPathComponent(id.uuidString)
        if let data = try? Data(contentsOf: filename) {
            if let uiImage = UIImage(data: data) {
                //return Image(uiImage: uiImage)
                return uiImage
            }
        }
        return nil
    }
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
