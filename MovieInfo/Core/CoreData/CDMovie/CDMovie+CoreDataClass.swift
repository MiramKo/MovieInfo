//
//  CDMovie+CoreDataClass.swift
//  MovieInfo
//
//  Created by Михаил Костров on 21/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDMovie)
public class CDMovie: NSManagedObject {

    public static func getMovie(withID id: Int) -> Movie? {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)
        let request = NSFetchRequest<CDMovie>(entityName: "CDMovie")
        request.entity = entitydesc
        let pred = NSPredicate(format: "id = %i", Int32(id))
        request.predicate = pred
        
        do {
            let results = try context.fetch(request)
            guard let exidted = results.first else { return nil }
            return self.createMovie(fromCDMovie: exidted)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    private static func createMovie(fromCDMovie cdMovie: CDMovie) -> Movie {
        
        let voteAverage = cdMovie.voteAverage
        let popularity = 0.0
        let id = cdMovie.id
        let video = false
        let voteCount = 0
        let title = cdMovie.title
        let releaseDate = cdMovie.releaseDate
        let originalLanguage = cdMovie.originalLanguage
        let originalTitle = cdMovie.originalTitle
        let genreIds = cdMovie.genreIds
        let backdropPath = cdMovie.backdropPath
        let adult = false
        let overview = cdMovie.overview
        let posterPath = cdMovie.posterPath
        
        let movie = Movie(popularity: popularity, id: Int(id), video: video, voteCount: voteCount, voteAverage: voteAverage, title: title, releaseDate: releaseDate, originalLanguage: originalLanguage, originalTitle: originalTitle, genreIds: genreIds, backdropPath: backdropPath, adult: adult, overview: overview, posterPath: posterPath)
        
        return movie
    }
    
    
    @discardableResult
    public static func removeCDMovie(withID id: Int) -> Bool {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)
        let request = NSFetchRequest<CDMovie>(entityName: "CDMovie")
        request.entity = entitydesc
        let pred = NSPredicate(format: "id = %i", Int32(id))
        request.predicate = pred
        
        do {
            let results = try context.fetch(request)
            
            for object in results {
                context.delete(object)
            }
            try context.save()
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    public static func makeCDMovie(fromMovie movie: Movie) -> Bool {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)
            else {
                return false
        }
        
        let cdMovie = CDMovie(entity: entity, insertInto: context)
        cdMovie.id = Int32(movie.id)
        cdMovie.backdropPath = movie.backdropPath
        cdMovie.genreIds = movie.genreIds
        cdMovie.originalLanguage = movie.originalLanguage
        cdMovie.originalTitle = movie.originalTitle
        cdMovie.overview = movie.overview
        cdMovie.posterPath = movie.posterPath
        cdMovie.releaseDate = movie.releaseDate
        cdMovie.title = movie.title
        cdMovie.voteAverage = movie.voteAverage
        
        do{
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public static func getAllMoviesInCD() -> [Movie] {
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)
        let request = NSFetchRequest<CDMovie>(entityName: "CDMovie")
        request.entity = entitydesc
        request.predicate = nil
        
        do {
            let results = try context.fetch(request)
            var movies = [Movie]()
            for result in results {
                movies.append(self.createMovie(fromCDMovie: result))
            }
            return movies
        } catch let error {
            print(error)
            return [Movie]()
        }
    }
}
