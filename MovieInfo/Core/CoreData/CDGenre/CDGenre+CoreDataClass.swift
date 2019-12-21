//
//  CDGenre+CoreDataClass.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import UIKit
import CoreData

@objc(CDGenre)
public class CDGenre: NSManagedObject {

    
    static func makeOrUpdate(fromModel model: GenresListModel) {
        
        guard let genres = model.getGenres() else { return }
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        
        for genre in genres {
            let id = genre.id
            let object = getUniqueInstance(from: Int16(id), in: context)
            
            object.id = Int16(id)
            object.name = genre.name
            object.language = Locale.current.languageCode ?? "en"
        }
        
        do{
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private static func getUniqueInstance(from id: Int16, in context: NSManagedObjectContext) -> CDGenre {
        
        typealias Entity = CDGenre

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDGenre", in: context)
        let request = NSFetchRequest<Entity>(entityName: "CDGenre")
        request.entity = entitydesc
        let pred = NSPredicate(format: "id = %i", id)
        request.predicate = pred
        
        let results = try? context.fetch(request)
        
        guard let exidted = results?.first else {
            return Entity(entity: entity(), insertInto: context)
        }
        return exidted
    }
    
    public static func getValues(forIDS ids:[Int]) -> [String: Int] {
        typealias Entity = CDGenre
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        
        var result = [String: Int]()
        
        let entitydesc = NSEntityDescription.entity(forEntityName: "CDGenre", in: context)
        let request = NSFetchRequest<Entity>(entityName: "CDGenre")
        request.entity = entitydesc
        
        let language = Locale.current.languageCode ?? "en"
        
        for id in ids {
            let pred = NSPredicate(format:"id = %@ AND language = %@", argumentArray: [id, language])
            request.predicate = pred
            
            let results = try? context.fetch(request)
            
            if let exidted = results?.first {
                result[exidted.name] = Int(exidted.id)
            }
        }
        
        return result
    }
    
}
