//
//  MovieListViewModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieListViewModel {
    
    public func getHeaderHeght(forWidth width: CGFloat) -> CGFloat {
        if MoviesManager.shared.getCurrentMode() == "MENU_ALL" {
            return width * 0.1484375
        } else {
            return 0.01
        }
        
    }
    
    public func getFooterHeight(forWidth width: CGFloat) -> CGFloat {
        
        guard let pagesCount = MoviesManager.shared.getTotalPages()
            else {
                return 0.01
        }
        
        if pagesCount > 1 {
            return width * 0.18
        } else {
            return 0.01
        }
    }

    public func getRowsCount() -> Int {
        return MoviesManager.shared.getNumberOfMovies()
    }
    
    public func config(cell: MovieListTableViewCell, forRow: Int) {
        
        cell.releaseDate.text = ""
        cell.title.text = ""
        cell.rating.text = ""
        cell.poster.image = UIImage(named: "icons8-rocket")
        cell.releaseDateTitle.text = NSLocalizedString("RELEASE_DATE", comment: "RELEASE_DATE")
        
        guard let movie = MoviesManager.shared.getMovie(atIndex: forRow) else { return }
        cell.releaseDate.text = movie.releaseDate
        cell.title.text = movie.title
        cell.rating.text = "\(movie.voteAverage)/10"
        let imageAdress = movie.posterPath
        cell.poster.setImage(withAdress: imageAdress, andType: .poster)
    }
    
    public func config(table: UITableView) {

        table.backgroundColor = .white //Colors.shared.getBacgroundColor()
        
        let headerNib = UINib(nibName: "MovieListHeader", bundle: nil)
        table.register(headerNib, forHeaderFooterViewReuseIdentifier: "MovieListHeader")
        
        let footerNib = UINib(nibName: "MovieListTableViewFooter", bundle: nil)
        table.register(footerNib, forHeaderFooterViewReuseIdentifier: "MovieListTableViewFooter")
    }
    
    public func config(footer: MovieListTableViewFooter) {
        
        guard let currentPage = MoviesManager.shared.getCurrentPage(),
            let totalPages = MoviesManager.shared.getTotalPages()
            else {
                return
        }
        
        if (MoviesManager.shared.getCurrentMode() == "MENU_FAVORITES") || (totalPages < 2) {
            footer.pageCount.text = ""
        } else {
            let baseText = NSLocalizedString("PAGE_COUNT", comment: "PAGE_COUNT")
            let text = baseText.replacingOccurrences(of: "NN", with: "\(currentPage)").replacingOccurrences(of: "PP", with: "\(totalPages)")
            footer.pageCount.text = text
        }
    }
    
    public func config(navigationItems item: UINavigationItem) {
        
        if MoviesManager.shared.getCurrentMode() == "MENU_ALL" {
            item.rightBarButtonItem?.isEnabled = true
        } else {
            item.rightBarButtonItem?.isEnabled = false
        }
    }
}
