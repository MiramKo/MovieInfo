//
//  MovieInfoCell.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieInfoCell: UICollectionViewCell{

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    

    @IBOutlet weak var movieInfoCellTitle: UILabel!
    @IBOutlet weak var movieInfoCellOriginalTitle: UILabel!
    @IBOutlet weak var movieInfoCellDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.text = ""
        self.originalTitle.text = ""
        self.date.text = ""
    }
    
}
