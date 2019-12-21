//
//  MovieListTableViewFooter.swift
//  MovieInfo
//
//  Created by Михаил Костров on 23/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieListTableViewFooter: UITableViewHeaderFooterView {
    
    @IBAction func previous(_ sender: Any) {
        MoviesManager.shared.previousPage()
    }
    
    @IBAction func next(_ sender: Any) {
        MoviesManager.shared.nextPage()
    }
    
    @IBOutlet weak var pageCount: UILabel!

}
