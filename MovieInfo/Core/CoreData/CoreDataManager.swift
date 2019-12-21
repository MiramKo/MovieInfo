//
//  CoreDataManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 12/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {

    public static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MovieInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
