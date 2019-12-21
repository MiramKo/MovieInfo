//
//  CDMovie+CoreDataProperties.swift
//  MovieInfo
//
//  Created by Михаил Костров on 21/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: [Int]
    @NSManaged public var id: Int32
    @NSManaged public var originalLanguage: String
    @NSManaged public var originalTitle: String
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String
    @NSManaged public var title: String
    @NSManaged public var voteAverage: Double

}
