//
//  ImageSizeCounter.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class ImageSizeCounter {
    
    private var path: String?
    
    public func count() -> (totalSize: Double, filesCount: Int) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        self.path = paths.first

        guard let path = self.path,
            let files = FileManager.default.subpaths(atPath: path)
            else {
                return (0.0, 0)
        }
        var totalSize = 0.0
        
        for file in files {
            
            totalSize += self.getSize(forFile: file)
        }
        
        let totalSizeInMB = totalSize / 1048576
        print(path)
        print("SIZE OF IMAGES???????????????????")
        print(totalSizeInMB)
        return (totalSizeInMB, files.count)
    }
    
    private func getSize(forFile file: String) -> Double {
        
        guard let path = self.path
            else {
                return 0
        }
        
        let fullPath = path + "/" + file
        let fileManager = FileManager.default
        
        do {
            let attributes = try fileManager.attributesOfItem(atPath: fullPath)
            let size = attributes[FileAttributeKey.size] as? Double ?? 0
            return size
        } catch let error {
            print(error.localizedDescription)
            return 0
        }
        
    }
    
}
