//
//  SlideMenuViewModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

public enum MenuOptions: String {
    case all = "MENU_ALL"
    case upcoming = "MENU_UPCOMING"
    case nowPlaying = "MENU_NOW_PLAYING"
    case favorites = "MENU_FAVORITES"
    case search = "SEARCH"
}

public let MENU_OPTIONS: Array<MenuOptions> = [
    .all,
    .upcoming,
    .nowPlaying,
    .favorites
]

class SlideMenuViewModel {
    
    init() {
    }
    
    public func config(cell: SlideMenuCell, forIndex index: Int) -> UITableViewCell {
        cell.textLabel?.textColor = Colors.shared.getTextColor()
        cell.backgroundColor = Colors.shared.getBacgroundColor()
        
        cell.textLabel?.text = NSLocalizedString(MENU_OPTIONS[index].rawValue, comment: MENU_OPTIONS[index].rawValue)
        cell.tag = index
        return cell
    }
    
    public func getNumberOfRows() -> Int {
        return MENU_OPTIONS.count
    }
    
    public func config(superView: UIView) {
        superView.backgroundColor = UIColor.clear
    }
    
    public func createTableView(withFrame frame: CGRect) -> UITableView {
        let height = frame.height
        let width = frame.width - 100
        
        let tableView = UITableView(frame: CGRect(x: -width, y: 0, width: width, height: height), style: .plain)
        tableView.backgroundColor = Colors.shared.getBacgroundColor()
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(UINib(nibName: "SlideMenuCell", bundle: nil), forCellReuseIdentifier: "SlideMenuCell")
        tableView.tableFooterView = UIView()
        tableView.layer.shadowColor = UIColor.gray.cgColor
        
        return tableView
    }
    
    public func animate(tableView view: UITableView, completion: @escaping ()->()) {
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        view.frame.origin.x = -view.frame.width-view.frame.origin.x
        }) { (finished) -> Void in
            completion()
        }
    }
    
    public func createalphaView(withFrame frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        view.alpha = 0.35
        return view
    }
}

