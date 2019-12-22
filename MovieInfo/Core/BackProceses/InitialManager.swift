//
//  InitialManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class InitialManager {
    
    private let defaults = UserDefaults.init()
    private var configError: MovieInfoError?
    private var genresError: MovieInfoError?
    
    private var prepareConfigs: Bool = false {
        didSet {
            self.checkPreparations()
        }
    }
    
    private var prepareGenres: Bool = false {
        didSet {
            self.checkPreparations()
        }
    }
    
    private var prepareMovies: Bool = false {
        didSet {
            self.checkPreparations()
        }
    }
    
    private func checkPreparations() {
        if self.prepareConfigs && self.prepareGenres && self.prepareMovies {
            self.defaults.set(true, forKey: "firstStartFlag")
            NotificationCenter.default.post(name: .preparationsDone, object: nil)
        }
    }
    
    private func preparationsWithErrors() {
        NotificationCenter.default.post(name: .preparationsFail, object: nil)
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(moviesRecived), name: .newDataObtained, object: nil)
    }
    
    @objc
    private func moviesRecived() {
        self.prepareMovies = true
    }
    
    public func getErrors() -> [MovieInfoError] {
        var errors = [MovieInfoError]()
        if let error = self.configError {
            errors.append(error)
        }
        
        if let error = self.genresError {
            errors.append(error)
        }
        
        return errors
    }
    
    public func prepare() {
        self.genresError = nil
        self.configError = nil
        MoviesManager.shared.prepareAtStart()
        self.firstStartCheck()
    }
    
    private func firstStartCheck() {
        
        let cleaner = ImageCleaner()
        cleaner.clearIfNeeded()
        
        let firstStart = !self.defaults.bool(forKey: "firstStartFlag")
    
        if firstStart {
            let configaApi = MDBAPIFactory.getAPI(withType: .configuration)
            configaApi.request() { [weak self] value, error in
                if let error = error {
                    self?.configError = error
                    self?.preparationsWithErrors()
                }
                else {
                    self?.prepareConfigs = true
                }
            }
            
            let genresApi = MDBAPIFactory.getAPI(withType: .genreList)
            genresApi.request() { [weak self] value, error in
                if let error = error {
                    self?.genresError = error
                    self?.preparationsWithErrors()
                }
                else {
                   self?.prepareGenres = true
                    guard let value = value as? GenresListModel else { return }
                    CDGenre.makeOrUpdate(fromModel: value)
                }
            }
        } else {
            self.checkConfigs()
            self.prepareGenres = true
        }
    }
    
    private func checkConfigs() {
        
        let dateOfConfigUpdate = self.defaults.double(forKey: "dateOfConfigUpdate")
        
        let currentDate = Date().timeIntervalSince1970
        let fourDaysInSeconds = 345600.0

        if currentDate - dateOfConfigUpdate > fourDaysInSeconds {
            let configurationAPI = MDBAPIFactory.getAPI(withType: .configuration)
            configurationAPI.request() {_,_ in
                self.prepareConfigs = true
            }
        } else {
            self.prepareConfigs = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .newDataObtained, object: nil)
    }
    
}
