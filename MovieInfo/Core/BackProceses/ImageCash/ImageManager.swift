//
//  ImageManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 28/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class ImageManager {
    
    private let adress: String
    private let type: ImageType
    
    init(forImageType type: ImageType, withAdress adress: String) {
        self.adress = adress
        self.type = type
    }
    
    public func setImage(forView view: UIImageView) {
        
        let emptyImage = UIImage(named: "image-placeholder")
        view.image = emptyImage
        
        guard self.adress != ""
            else {
                return
        }
        
        self.getImage() { [weak view] (image, error) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                view?.image = image
            }
        }
    }
    
    private func getImage(completion: @escaping(_ :UIImage?, _ :Error?) -> ()) {
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async {
            
            if let cdImage = CDImage.checkAndGetImage(withAdress: self.adress),
                let image = UIImage(data: cdImage.image!)
            {
                completion(image, nil)
            } else {
                let imageRequest = ImageRequest(adress: self.adress, type: self.type)
                imageRequest.request { (image, error) in
                    guard let image = image else { return completion(nil, error) }
                    CDImage.make(image: image, withAdress: self.adress)
                    completion(image, nil)
                }
            }
        }
    }
}
