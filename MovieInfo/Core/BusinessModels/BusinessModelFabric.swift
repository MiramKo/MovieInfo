//
//  BusinessModelFabric.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class BusinessModelFabric {
    
    public static func createModel(forAPI api: MDBAPIMethods, withData data: Data) throws -> BusinessModelProtocol {
        do {
            switch api {
            case .movieCertificationList:
                return try MovieCertificationListModel(withData: data)
            case .genreList:
                return try GenresListModel(withData: data)
            case .upcoming, .nowPlaying, .discover, .search:
                return try MovieListModel(withData: data)
            case .configuration:
                return try ConfigurationModel(withData: data)
            }
        } catch let error {
            throw error
        }
    }
}
