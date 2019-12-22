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
        NotificationCenter.default.post(name: .preparationsDone, object: nil)
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(moviesRecived), name: .newDataObtained, object: nil)
    }
    
    @objc
    private func moviesRecived() {
        self.prepareMovies = true
    }
    
    public func prepare() {
        MoviesManager.shared.prepareAtStart()
        self.firstStartCheck()
    }
    
    private func firstStartCheck() {
        
        let cleaner = ImageCleaner()
        cleaner.clearIfNeeded()
        
        let firstStart = !self.defaults.bool(forKey: "firstStartFlag")
    
        if firstStart {
            self.defaults.set(true, forKey: "firstStartFlag")
            let configaApi = MDBAPIFactory.getAPI(withType: .configuration)
            configaApi.request() {_,_ in
                self.prepareConfigs = true
            }
            
            let genresApi = MDBAPIFactory.getAPI(withType: .genreList)
            genresApi.request() { value, error in
                self.prepareGenres = true
                guard let value = value as? GenresListModel else { return }
                DispatchQueue.main.async {
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
