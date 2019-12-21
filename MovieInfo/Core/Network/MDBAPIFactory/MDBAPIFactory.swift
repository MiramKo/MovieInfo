//
//  MDBAPIFactory.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class MDBAPIFactory {
    
    public static func getAPI(withType type: MDBAPIMethods, forPage page: Int = 1) -> MDBAPIPAbstractFactory {
        switch type {
        case .guestSession:
            return GuestSession()
        case .movieCertificationList:
            return MovieCertificationList()
        case .genreList:
            return GenresList()
        case .upcoming:
            return Upcoming(page: page)
        case .nowPlaying:
            return NowPlaying(page: page)
        case .discover:
            return Discover(page: page)
        case .search:
            return Search(page: page)
        case .configuration:
            return Configuration()
        }
    }
}
