//
//  MovieCertificationList.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class MovieCertificationList: MDBAPIPAbstractFactory {
    
    var theMovieDBAPIMethod: MDBAPIMethods = .movieCertificationList
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
}
