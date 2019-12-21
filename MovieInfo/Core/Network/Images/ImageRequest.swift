//
//  ImageRequest.swift
//  MovieInfo
//
//  Created by Михаил Костров on 12/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class ImageRequest {
    
    private var imageURL: String
    
    init(adress: String, type: ImageType) {
        let defaults = UserDefaults()
        
        guard let url = defaults.string(forKey: "baseURL")
            else {
            self.imageURL = ""
            return
        }
        
        let size = defaults.integer(forKey: type.rawValue)
        
        self.imageURL = url + "w\(size)/" + adress
    }
    
    func request(completion: @escaping(_ :UIImage?, _ :Error?) -> ()) {
        
        guard let url = URL(string: self.imageURL)
            else {
                //todo error parser
                return completion(nil, nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil{
                print("Error -> \(error)")
                completion(nil, error)
            }else{
                guard let data = data,
                    let image = UIImage(data: data)
                    else {
                        return completion(nil, error)
                }
                completion(image, nil)
            }
        }
        task.resume()
    }
}
