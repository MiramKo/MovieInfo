//
//  SlideMenuCoordinator.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuCoordinator {
    
    static let shared = SlideMenuCoordinator()
    
    private weak var menuAppearenceDelegate: MenuAppearenceDelegate?
    
    init() {
        
    }
    
    public func set(delegate: MenuAppearenceDelegate) {
        self.menuAppearenceDelegate = delegate
    }
}

extension SlideMenuCoordinator: OpenMenuButtonDelegate {
    
    func openMenuButtonTapped() {
        self.menuAppearenceDelegate?.openMenuButtonTapped()
    }
}

extension SlideMenuCoordinator: MenuButtonTappedDelegate {
    func tappedButton(withIndex index: Int) {
        let mode = MENU_OPTIONS[index]
        MoviesManager.shared.changeMode(newMode: mode)
    }
}
