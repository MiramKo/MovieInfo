//
//  UIImageExtension.swift
//  MovieInfo
//
//  Created by Михаил Костров on 13/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

public enum ImageType: String {
    case poster = "posterSize"
    case backdrop = "backdropSize"
}

extension UIImageView {
    
    public func setImage(withAdress adress: String?, andType type: ImageType) {
    
        let imageManager = ImageManager()
        
        let emptyImage = UIImage(named: "image-placeholder")
        self.image = emptyImage
        
        guard let adress = adress else { return }
        
        imageManager.getImage(withAdress: adress, type: type) { [weak self] (image, error) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
