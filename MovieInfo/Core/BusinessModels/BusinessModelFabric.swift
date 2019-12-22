//
//  BusinessModelFabric.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class BusinessModelFabric {
    
    public static func createModel(forAPI api: MDBAPIMethods, withData data: Data) -> BusinessModelProtocol {
        switch api {
        case .movieCertificationList:
            return MovieCertificationListModel(withData: data)
        case .genreList:
            return GenresListModel(withData: data)
        case .upcoming, .nowPlaying, .discover, .search:
            return MovieListModel(withData: data)
        case .configuration:
            return ConfigurationModel(withData: data)
        }
    }
}
