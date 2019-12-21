//
//  Configuration.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class Configuration: MDBAPIPAbstractFactory {
    
    var theMovieDBAPIMethod: MDBAPIMethods = .configuration
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
}
