//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Chris on 4/25/20.
//  Copyright © 2020 CodePika. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16

}
