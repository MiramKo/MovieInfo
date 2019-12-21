//
//  MovieCertificationListModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class MovieCertificationListModel: BusinessModelProtocol {
    
    private struct MovieCertificationList: Codable {
        let certifications: [String:[Certification]]
    }
    
    struct Certification: Codable {
        let certification: String
        let meaning: String
        let order: Int
    }
    
    private var certifications: [String: [Certification]]? = nil
    
    init (withData data: Data) {
        
        do {
            let serialisedData = try JSONDecoder().decode(MovieCertificationList.self, from: data)
            self.certifications = serialisedData.certifications
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func getCertifications() -> [String: [Certification]]? {
        return self.certifications
    }
}
