//
//  Filters.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class Filters {
    
    static let shared = Filters()
    
    enum SortTypes: String {
        case popularity = "popularity.desc"
        case releaseDate = "release_date.desc"
        case voteAverage = "vote_average.desc"
    }
    
    private var sortBy: SortTypes? = nil
    private var primaryReleaseYear: String? = nil
    private var genres: [Int]? = nil
    private var searchWord: String? = nil
    
    public func setReleaseYearFilter(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        self.primaryReleaseYear = year
    }
    
    public func setGenresFilter(genresIds: [Int]) {
        self.genres = genresIds
    }
    
    public func setSort(by type: SortTypes) {
        self.sortBy = type
    }
    
    public func setSearchWord(word: String) {
        self.searchWord = word
    }
    
    public func clearReleaseYearFilter() {
        self.primaryReleaseYear = nil
    }
    
    public func clearSort() {
        self.sortBy = nil
    }
    
    public func clearGenresFilter() {
        self.genres = nil
    }
    
    public func clearSearchWord() {
        self.searchWord = nil
    }
    
    public func clearAllFilters() {
        self.clearSort()
        self.clearGenresFilter()
        self.clearReleaseYearFilter()
    }
    
    public func makeParamsForDiscover() -> [String: String] {
        self.clearSearchWord()
        var params = [String: String]()
        
        if let sort = self.sortBy {
            params["sort_by"] = sort.rawValue
        } else {
            params["sort_by"] = SortTypes.popularity.rawValue
        }
        
        if let genres = self.genres {
            params["with_genres"] = genres.map { (value) -> String in
                return String(value)
            }.joined(separator: ",")
        }
        
        if let primaryReleaseYear = self.primaryReleaseYear {
            params["primary_release_year"] = primaryReleaseYear
        }
        
        return params
    }
    
    public func makeParamsForSearch() -> [String: String] {
        self.clearAllFilters()
        var params = [String: String]()
        
        if let word = self.searchWord {
            params["query"] = word
        }
        return params
    }
}
