//
//  MDBError.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

public struct MDBError: Codable {
    let statusMessage: String
    let statusCode: Int
}
