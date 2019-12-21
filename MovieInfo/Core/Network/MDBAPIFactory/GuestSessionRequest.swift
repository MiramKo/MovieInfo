//
//  GuestSessionRequest.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class GuestSessionRequest: TheMovieDBAPIProtocol {
    var theMovieDBAPIMethod: TheMovieDBAPIMethods
    
    var httpMethod: HTTPMethods
    
    func parse<T>(data: Codable, decodingStruct: T.Type) -> BusinessModelProtocol? where T : Decodable, T : Encodable {
        <#code#>
    }
    
    
    private struct serialisationStruct: Codable {
        let success: Bool
        let guest_session_id: String
        let expires_at: String
    }
    
    func request() -> (result: BusinessModelProtocol?, error: Error?) {
        
    }
    
    func parse(data: Data) -> BusinessModelProtocol? {
        do {
            let serialisedData = try JSONDecoder().decode(serialisationStruct.self, from: data)
            let session = serialisedData.guest_session_id
            return SessionModel(withSession: session)
        } catch let error {
            print(error)
            return nil
        }
    }
    
}
