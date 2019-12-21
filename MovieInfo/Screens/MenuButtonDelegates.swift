//
//  MenuButtonDelegates.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

protocol OpenMenuButtonDelegate: class{
    func openMenuButtonTapped()
}

protocol MenuButtonTappedDelegate: class {
    func tappedButton(withIndex index: Int)
}
