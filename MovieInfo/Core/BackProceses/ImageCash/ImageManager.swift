//
//  ImageManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

public struct ImageRating {
    let adress: String
    let updateDate: Date
    let usageCount: Int64
    var usageRating: Int
    var updateRating: Int
    var totalRating: Int = 0
    
    public mutating func countTotalRating() {
        self.totalRating = self.usageRating + self.updateRating
    }
}

class ImageManager {
    
    public static let shared = ImageManager()
    
    private var askedImages = [String: Int]()
    
    public func getImage(withAdress adress: String, type: ImageType, completion: @escaping(_ :UIImage?, _ :Error?) -> ()) {
        
        guard  !(self.askedImages[adress] != nil)
            else {
                return completion(nil, nil)
        }
        
        
        self.askedImages[adress] = 0
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async {
            
            if let cdImage = CDImage.checkAndGetImage(withAdress: adress),
                let image = UIImage(data: cdImage.image!)
            {
                self.askedImages.removeValue(forKey: adress)
                completion(image, nil)
            } else {
                let imageRequest = ImageRequest(adress: adress, type: type)
                imageRequest.request { (image, error) in
                    guard let image = image else { return completion(nil, error) }
                    CDImage.make(image: image, withAdress: adress)
                    self.askedImages.removeValue(forKey: adress)
                    completion(image, nil)
                }
            }
        }
    }
    
    public func clearIfNeeded() {
        let imageSizeCounter = ImageSizeCounter()
        let sizes = imageSizeCounter.count()
        
        if (sizes.totalSize - 100.0) > 20 {
            
            let queue = DispatchQueue.global(qos: .background)
            
            queue.async {
                
                let images = CDImage.getAllImages()
                let countImagesToDelete = self.countImagesToDelete(filesCount: sizes.filesCount, cdImagesCount: images.count)
                let ratedImages = self.rate(images: images)
                let imageToDeleteAdreses = self.createAdresesToDelete(fromImages: ratedImages, countImagesToDelete: countImagesToDelete)
                
                for image in imageToDeleteAdreses {
                    CDImage.removeImage(withAdress: image)
                }
            }
        }
    }
    
    private func countImagesToDelete(filesCount: Int, cdImagesCount: Int) -> Int {
        
        let amountOfMBToDelete = 100.0
        
        let imagesVariance = Int((filesCount / cdImagesCount) * 100)
        
        var imageToDeleteSize = 0.0
        
        switch imagesVariance {
        case 0...10:
            imageToDeleteSize = 0.150
        case 11...50:
            imageToDeleteSize = (0.150 + 1.0) / 2
        case 51...100:
            imageToDeleteSize = 1.0
        default:
            imageToDeleteSize = 1.0
        }
        
        let countImagesToDelete = Int(amountOfMBToDelete / imageToDeleteSize)
        
        return countImagesToDelete
    }
    
    private func rate(images: [ImageRating]) -> [ImageRating] {
        
        var usageRating = images.sorted { $0.usageCount < $1.usageCount }
        
        for image in usageRating.enumerated() {
            usageRating[image.offset].usageRating = image.offset
        }
        
        var dateRating = usageRating.sorted { $0.updateDate < $1.updateDate }
        
        for image in dateRating.enumerated() {
            dateRating[image.offset].updateRating = image.offset
            dateRating[image.offset].countTotalRating()
        }
        
        return dateRating
    }
    
    private func createAdresesToDelete(fromImages images: [ImageRating], countImagesToDelete: Int) -> [String] {
        var imageToDeleteAdreses = [String]()
        var count = countImagesToDelete
        
        if count > images.count {
            imageToDeleteAdreses = images.map { $0.adress }
        } else {
            while count > 0 {
                imageToDeleteAdreses.append(images[count-1].adress)
                count -= 1
            }
        }
        return imageToDeleteAdreses
    }
}
