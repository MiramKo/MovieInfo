//
//  MasterVC.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SlideMenuCoordinator.shared.set(delegate: self)
    }
}

extension MasterVC: MenuAppearenceDelegate {
    func openMenuButtonTapped() {
        performSegue(withIdentifier: "showMenu", sender: nil)
        print("openMenu button tapped")
    }
}
