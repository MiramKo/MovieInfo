//
//  ConfigurationModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class ConfigurationModel: BusinessModelProtocol {
    
    private struct Configuration: Codable {
        let images: Images
        let changeKeys: [String]
    }
    
    private struct Images: Codable {
        let baseUrl: String
        let secureBaseUrl: String
        let backdropSizes: [String]
        let logoSizes: [String]
        let posterSizes: [String]
        let profileSizes: [String]
        let stillSizes: [String]
    }
    
    
    init (withData data: Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let serialisedData = try decoder.decode(Configuration.self, from: data)
            self.write(config: serialisedData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func write(config: Configuration) {
        let defaults = UserDefaults.init()
        defaults.set(config.images.secureBaseUrl, forKey: "baseURL")
        
        let backdropSize = self.takeSizeFrom(array: config.images.backdropSizes)
        defaults.set(backdropSize, forKey: "backdropSize")
        
        let posterSize = self.takeSizeFrom(array: config.images.posterSizes)
        defaults.set(posterSize, forKey: "posterSize")
        
        let date = Date()
        defaults.set(date.timeIntervalSince1970, forKey: "dateOfConfigUpdate")
    }
    
    private func takeSizeFrom(array: [String]) -> Int {
        let arrayWithoutCharacters: [String] = array.filter{ $0 != "original" }
            .map{$0.replacingOccurrences(of: "w", with: "")}
        let intArray: [Int] = arrayWithoutCharacters.map{(Int($0) ?? 0)}.sorted{ $0 > $1 }
        
        if intArray.count > 1 {
            return intArray[intArray.count - 1]
        } else if let size = intArray.first {
            return size
        } else {
            return 0
        }
    }
}
