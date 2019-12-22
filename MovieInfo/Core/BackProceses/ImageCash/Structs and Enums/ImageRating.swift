//
//  ImageRating.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

public struct ImageRating {
    let adress: String
    let updateDate: Date
    let usageCount: Int64
    var usageRating: Int
    var updateRating: Int
    var totalRating: Int = 0
    
    public mutating func countTotalRating() {
        self.totalRating = self.usageRating + self.updateRating
    }
}
