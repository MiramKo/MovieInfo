//
//  Discover.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class Discover: MDBAPIPAbstractFactory {

    var theMovieDBAPIMethod: MDBAPIMethods = .discover
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
    
    init(page: Int) {
        self.additionalParams["page"] = String(page)
        self.additionalParams["language"] = Locale.current.languageCode ?? "en"
        self.additionalParams["region"] = Locale.current.regionCode ?? "ru"
        
        let params = Filters.shared.makeParamsForDiscover()
        params.forEach { (key, value) in
            self.additionalParams[key] = value
        }
    }
}
