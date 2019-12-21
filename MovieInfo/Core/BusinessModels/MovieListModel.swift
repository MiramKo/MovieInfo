//
//  MovieListModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class MovieListModel: BusinessModelProtocol {
    
    private struct MovieList: Codable {
        let results: [Movie]
        let totalPages: Int
        let totalResults: Int
        let page: Int
    }
    
    private var movies: [Movie]?
    private var page = 0
    private var totalPages = 0
    
    init(withData data: Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let serialisedData = try decoder.decode(MovieList.self, from: data)
            self.movies = serialisedData.results
            self.page = serialisedData.page
            self.totalPages = serialisedData.totalPages
        } catch let error {
            print(error.localizedDescription)
        }
    }

    init(withMovies movies: [Movie]) {
        self.movies = movies
    }
    
    public func getMovies() -> [Movie]? {
        return self.movies
    }
    
    public func getCurrentPage() -> Int {
        return self.page
    }
    
    public func gettotalPagesCount() -> Int {
        return self.totalPages
    }
    
    public func getMovie(withIndex index: Int) -> Movie? {
        guard let movies = self.movies else { return nil }
        return movies[index]
    }
}
