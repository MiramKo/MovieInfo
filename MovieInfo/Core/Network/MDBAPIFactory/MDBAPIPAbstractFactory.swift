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
    func request(completion: @escaping(_ :BusinessModelProtocol?, _ : MovieInfoError?) -> ())
}

extension MDBAPIPAbstractFactory {
    var apiKey: String { return "246f272f883ceb51311f452fe02760c0" }
    var baseURL: String { return "https://api.themoviedb.org/3" }
    var requiredParams: [String:String] { return ["api_key":self.apiKey] }
    
    
    func request(completion: @escaping(_ : BusinessModelProtocol?, _ : MovieInfoError?) -> ()) {
        let url = self.baseURL + theMovieDBAPIMethod.rawValue
        
        var params: [String:String] = self.requiredParams
        if !additionalParams.isEmpty {
            params = additionalParams
            params["api_key"] = self.apiKey
        }
        
        HTTPRequest.request(url: url, parameters: params, method: self.httpMethod.rawValue) { (data, response, error) in
            if error != nil{
                let miError = MovieInfoError(.requestError)
                completion(nil, miError)
            }else{
                guard let data = data
                    else {
                        let miError = MovieInfoError(.dataLoadFail)
                        return completion(nil, miError)
                }
                
                let parsedResponse = self.responseParser(response, data)
                
                if parsedResponse.status {
                    let parsedModel = self.parseBusinessModel(fromData: data)
                    completion(parsedModel.model, parsedModel.error)
                } else {
                    completion(nil, parsedResponse.error)
                }

            }
        }
    }
    
    private func responseParser(_ response : URLResponse?, _ data: Data) -> (status: Bool, error: MovieInfoError?) {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode
            else {
                return (false, MovieInfoError(.statusParseError))
        }
        
        if statusCode == 200 {
            return (true, nil)
        } else {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let serialisedData = try decoder.decode(MDBError.self, from: data)
                let code = serialisedData.statusCode
                let message = serialisedData.statusMessage
                let error = MovieInfoError(code, message)
                return (false, error)
            } catch {
                return (false, MovieInfoError(.parseErrorDataFail))
            }
        }
    }
    
    private func parseBusinessModel(fromData data: Data) -> (model: BusinessModelProtocol?, error: MovieInfoError?) {
        
        do {
            let businessModel = try BusinessModelFabric.createModel(forAPI: self.theMovieDBAPIMethod, withData: data)
            return (businessModel, nil)
        } catch let error {
            return (nil, error as? MovieInfoError)
        }
        
    }
    
}
