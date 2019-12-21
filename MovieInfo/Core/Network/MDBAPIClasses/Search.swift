//
//  Search.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class Search: MDBAPIPAbstractFactory {

    var theMovieDBAPIMethod: MDBAPIMethods = .search
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
    
    init(page: Int) {
        self.additionalParams["page"] = String(page)
        self.additionalParams["language"] = Locale.current.languageCode ?? "en"

        let params = Filters.shared.makeParamsForSearch()
        params.forEach { (key, value) in
            self.additionalParams[key] = value
        }
    }
}
