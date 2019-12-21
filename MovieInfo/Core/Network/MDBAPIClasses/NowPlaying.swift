//
//  NowPlaying.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class NowPlaying: MDBAPIPAbstractFactory {

    var theMovieDBAPIMethod: MDBAPIMethods = .nowPlaying
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
    
    init(page: Int) {
        self.additionalParams["page"] = String(page)
        self.additionalParams["language"] = Locale.current.languageCode ?? "en"
        self.additionalParams["region"] = Locale.current.regionCode ?? "ru"
    }
}
