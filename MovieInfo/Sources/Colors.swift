//
//  Colors.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    static let shared = Colors()
    
    func getTextColor() -> UIColor {
        return TEXT_COLOR
    }
    
    func getBacgroundColor() -> UIColor {
        return BACKGROUND_COLOR
    }
    
    func getSeparatorsColor() -> UIColor {
        return SEPARATORS_COLOR
    }
    
    private let TEXT_COLOR = UIColor.black
    private let BACKGROUND_COLOR = UIColor.white
    private let SEPARATORS_COLOR = UIColor.green
}
