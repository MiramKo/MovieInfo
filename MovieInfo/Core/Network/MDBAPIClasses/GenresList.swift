//
//  GenresList.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class GenresList: MDBAPIPAbstractFactory {
    
    var theMovieDBAPIMethod: MDBAPIMethods = .genreList
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
    
    init() {
        self.additionalParams["language"] = Locale.current.languageCode ?? "en"
    }
}
