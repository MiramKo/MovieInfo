//
//  CDImage+CoreDataProperties.swift
//  MovieInfo
//
//  Created by Михаил Костров on 13/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import Foundation
import CoreData


extension CDImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImage> {
        return NSFetchRequest<CDImage>(entityName: "CDImage")
    }

    @NSManaged public var adress: String?
    @NSManaged public var image: Data?
    @NSManaged public var lasDateOfUsage: Date?
    @NSManaged public var usageCount: Int64

}
