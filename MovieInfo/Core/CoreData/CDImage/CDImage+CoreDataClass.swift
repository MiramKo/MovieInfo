//
//  CDImage+CoreDataClass.swift
//  MovieInfo
//
//  Created by Михаил Костров on 13/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//
//

import UIKit
import CoreData

@objc(CDImage)
public class CDImage: NSManagedObject {

    public static func checkAndGetImage(withAdress adress: String) -> CDImage? {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDImage", in: context)
        let request = NSFetchRequest<CDImage>(entityName: "CDImage")
        request.entity = entitydesc
        let pred = NSPredicate(format: "adress = %@", adress)
        request.predicate = pred
        
        do {
            let results = try context.fetch(request)
            guard let exidted = results.first else { return nil }
            self.update(image: exidted, inContext: context)
            return exidted
        } catch let error {
            print(error)
            return nil
        }
    }
    
    @discardableResult
    private static func update(image: CDImage, inContext context: NSManagedObjectContext) -> Bool {
        
        image.lasDateOfUsage = Date()
        image.usageCount += 1
        do{
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    public static func removeImage(withAdress adress: String) -> Bool {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDImage", in: context)
        let request = NSFetchRequest<CDImage>(entityName: "CDImage")
        request.entity = entitydesc
        let pred = NSPredicate(format: "adress = %@", adress)
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
    public static func make(image: UIImage, withAdress adress: String) -> Bool {
        
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CDImage", in: context)
            else {
                return false
        }
        
        let cdImage = CDImage(entity: entity, insertInto: context)
        
        guard let image: Data = image.pngData() else { return false }
        
        let currentDate = Date()
        
        cdImage.adress = adress
        cdImage.image = image
        cdImage.lasDateOfUsage = currentDate
        cdImage.usageCount = 1
        
        do{
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public static func getAllImages() -> [ImageRating] {
        let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()

        let entitydesc = NSEntityDescription.entity(forEntityName: "CDImage", in: context)
        let request = NSFetchRequest<CDImage>(entityName: "CDImage")
        request.entity = entitydesc
        request.predicate = nil
        
        do {
            let results = try context.fetch(request)

            var images = [ImageRating]()
            for result in results {
                if let adress = result.adress, let updateDate = result.lasDateOfUsage {
                    let imageRating = ImageRating(adress: adress, updateDate: updateDate, usageCount: result.usageCount, usageRating: 0, updateRating: 0)
                    images.append(imageRating)
                }
            }
            return images
        } catch let error {
            print(error)
            return [ImageRating]()
        }
    }
    
}
