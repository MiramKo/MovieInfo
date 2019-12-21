//
//  MDBAPIPAbstractFactory.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

struct DecodingStruct: Codable {
    
}

//TODO - errors
protocol MDBAPIPAbstractFactory {
    var theMovieDBAPIMethod: MDBAPIMethods { get }
    var httpMethod: HTTPMethods { get }
    var apiKey: String { get }
    var baseURL: String { get }
    var requiredParams: [String:String] { get }
    var additionalParams: [String:String] { get set }
    func request(completion: @escaping(_ :BusinessModelProtocol?, _ :Error?) -> ())
}

extension MDBAPIPAbstractFactory {
    var apiKey: String { return "246f272f883ceb51311f452fe02760c0" }
    var baseURL: String { return "https://api.themoviedb.org/3" }
    var requiredParams: [String:String] { return ["api_key":self.apiKey] }
    
    
    func request(completion: @escaping(_ :BusinessModelProtocol?, _ :Error?) -> ()) {
        let url = self.baseURL + theMovieDBAPIMethod.rawValue
        
        var params: [String:String] = self.requiredParams
        if !additionalParams.isEmpty {
            params = additionalParams
            params["api_key"] = self.apiKey
        }
        
        HTTPRequest.request(url: url, parameters: params, method: self.httpMethod.rawValue) { (data, response, error) in
            if error != nil{
                print("Error -> \(error)")
                completion(nil, error)
            }else{
                guard let data = data else { return completion(nil, error) }
                
                let businessModel = BusinessModelFabric.createModel(forAPI: self.theMovieDBAPIMethod, withData: data)
                completion(businessModel, nil)
            }
        }
    }
}
