//
//  MDBAPIMethods.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

enum MDBAPIMethods: String {
    case movieCertificationList = "/certification/movie/list"
    case genreList = "/genre/movie/list"
    case upcoming = "/movie/upcoming"
    case nowPlaying = "/movie/now_playing"
    case discover = "/discover/movie"
    case search = "/search/movie"
    case configuration = "/configuration"
}
