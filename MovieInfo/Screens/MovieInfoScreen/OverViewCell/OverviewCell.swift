//
//  OverviewCell.swift
//  MovieInfo
//
//  Created by Михаил Костров on 21/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class OverviewCell: UICollectionViewCell {

    @IBOutlet weak var overviewCellTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.overview.text = ""
    }

}
