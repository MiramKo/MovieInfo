//
//  DataManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class MoviesManager {
    
    static let shared = MoviesManager()
    
    private var movieList: MovieListModel? = nil
    private var choosenMode: MenuOptions = .all
    private var newDataInProcess = false
    private var choosenMovie: Movie? = nil
    
    public func prepareAtStart() {
        self.askforMovies(atPage: 1)
    }
    
    public func search(_ string: String) {
        Filters.shared.setSearchWord(word: string)
        self.changeMode(newMode: .search)
    }
    
    public func changeMode(newMode: MenuOptions) {
        if !self.newDataInProcess && (self.choosenMode != newMode) && (newMode != .favorites) {
            self.choosenMode = newMode
            self.askforMovies(atPage: 1)
        } else if !self.newDataInProcess && (self.choosenMode == .search) {
            self.askforMovies(atPage: 1)
        } else if !self.newDataInProcess && (newMode == .favorites) {
            self.askForFavoriteMovies()
            self.choosenMode = newMode
        }
    }
    
    public func nextPage() {
        guard let movies = self.movieList else { return }
        if !(movies.getCurrentPage() == movies.gettotalPagesCount()) {
            self.askforMovies(atPage: movies.getCurrentPage() + 1)
        }
    }
    
    public func previousPage() {
        guard let movies = self.movieList else { return }
        if movies.getCurrentPage() != 1 {
            self.askforMovies(atPage: movies.getCurrentPage() - 1)
        }
    }
    
    public func getCurrentMode() -> String {
        if self.choosenMode == .search {
            return MenuOptions.all.rawValue
        } else {
            return self.choosenMode.rawValue
        }
    }
    
    private func askForFavoriteMovies() {
        self.newDataInProcess = true
        let movies = CDMovie.getAllMoviesInCD()
        let movieList = MovieListModel(withMovies: movies)
        self.movieList = movieList
        self.newDataInProcess = false
        NotificationCenter.default.post(name: .newDataObtained, object: nil)
    }
    
    private func askforMovies(atPage page: Int) {
        self.newDataInProcess = true
        guard let api = self.createApi(pageForRequest: page)
            else {
               self.newDataInProcess = false
                return
        }
        api.request() { [weak self] (result, error) in
            guard let movieList = result as? MovieListModel else { return }
            self?.movieList = movieList
            self?.newDataInProcess = false
            NotificationCenter.default.post(name: .newDataObtained, object: nil)
        }
    }
    
    private func createApi(pageForRequest page: Int) -> MDBAPIPAbstractFactory? {
        
        switch self.choosenMode {
        case .all:
            return MDBAPIFactory.getAPI(withType: .discover, forPage: page)
        case .upcoming:
            return MDBAPIFactory.getAPI(withType: .upcoming, forPage: page)
        case .nowPlaying:
            return MDBAPIFactory.getAPI(withType: .nowPlaying, forPage: page)
        case .favorites:
            return nil
        case .search:
            return MDBAPIFactory.getAPI(withType: .search, forPage: page)
        }
    }
    
    public func getNumberOfMovies() -> Int {
        guard let moviesCount = self.movieList?.getMovies()?.count else { return 0 }
        return moviesCount
    }
    
    public func getMovie(atIndex: Int) -> Movie? {
        guard let movie = self.movieList?.getMovies()?[atIndex] else { return nil }
        return movie
    }
    
    public func getCurrentPage() -> Int? {
        return self.movieList?.getCurrentPage()
    }
    
    public func getTotalPages() -> Int? {
        return self.movieList?.gettotalPagesCount()
    }
    
    public func chooseMovie(withIndex index: Int) {
        guard let movie = self.movieList?.getMovie(withIndex: index)
            else {
                self.choosenMovie = nil
                return
        }
        self.choosenMovie = movie
    }
    
    public func getChoosenMovie() -> Movie? {
        return self.choosenMovie
    }
    
    public func makeMovieFavorite() {
       guard let movie = self.choosenMovie
        else {
            return
        }
        
        CDMovie.makeCDMovie(fromMovie: movie)
    }
    
    public func removeMovieFromFavorites() {
        guard let movie = self.choosenMovie
        else {
            return
        }
        
        CDMovie.removeCDMovie(withID: movie.id)
    }
}
