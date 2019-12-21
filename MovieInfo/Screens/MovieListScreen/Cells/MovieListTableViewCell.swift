//
//  MovieListTableViewCell.swift
//  MovieInfo
//
//  Created by Михаил Костров on 23/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDateTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.poster.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
