//
//  MovieListHeader.swift
//  MovieInfo
//
//  Created by Михаил Костров on 23/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieListHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var searchBar: UISearchBar!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = NSLocalizedString("SEARCHBAR_PLACEHOLDER", comment: "SEARCHBAR_PLACEHOLDER")
        guard let textfield = self.searchBar.value(forKey: "searchField") as? UITextField else { return }
        
        let atrString = NSAttributedString(string: placeholder, attributes: [.font : UIFont.systemFont(ofSize: 12, weight: .light)])
        textfield.attributedPlaceholder = atrString
    }
    
}
