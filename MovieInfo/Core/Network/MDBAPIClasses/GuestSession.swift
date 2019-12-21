//
//  GuestSession.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class GuestSession: MDBAPIPAbstractFactory {
    
    var theMovieDBAPIMethod: MDBAPIMethods = .guestSession
    var httpMethod: HTTPMethods = .get
    var additionalParams = [String : String]()
}
