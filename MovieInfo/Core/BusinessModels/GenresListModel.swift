//
//  GenresListModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class GenresListModel: BusinessModelProtocol {
    
    private struct Genres: Codable {
        let genres: [Genre]
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    private var genres: [Genre]? = nil
    
    init (withData data: Data) {
        do {
            let serialisedData = try JSONDecoder().decode(Genres.self, from: data)
            self.genres = serialisedData.genres
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func getGenres() -> [Genre]? {
        return self.genres
    }
}
