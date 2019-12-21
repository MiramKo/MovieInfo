//
//  CDGenre+CoreDataProperties.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import Foundation
import CoreData


extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var id: Int16
    @NSManaged public var language: String?
    @NSManaged public var name: String

}
