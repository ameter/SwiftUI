//
//  Settings.swift
//  SnowSeeker
//
//  Created by Chris on 5/12/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import Foundation

class Settings: ObservableObject {
    enum sort: String, CaseIterable {
        case alabetical, country, none
    }
    @Published var sortSelection = sort.none
    
    enum country: String, CaseIterable {
        case any, us = "U.S.", france, austria, italy, canada
    }
    @Published var filterCountry = country.any
    
    enum size: String, CaseIterable {
        case any, small, medium, large
    }
    @Published var filterSize = size.any
    
    enum price: String, CaseIterable {
        case any, low = "$", medium = "$$", high = "$$$"
    }
    @Published var filterPrice = price.any
}
