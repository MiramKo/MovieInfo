//
//  MovieListVC.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    private weak var openMenuButtonDelegate: OpenMenuButtonDelegate?
    private let viewModel = MovieListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.openMenuButtonDelegate?.openMenuButtonTapped()
    }
    
    @IBAction func filters(_ sender: Any) {
        
        let messageText = NSLocalizedString("WILL_BE_SOON", comment: "WILL_BE_SOON")
        let alert = UIAlertController(title: messageText, message: "", preferredStyle: .actionSheet)
        let actionText = NSLocalizedString("GOOD_TEXT", comment: "GOOD_TEXT")
        let action = UIAlertAction(title: actionText, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTitle()
        self.openMenuButtonDelegate = SlideMenuCoordinator.shared
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .newDataObtained, object: nil)
        
        self.viewModel.config(table: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.config(navigationItems: self.navigationItem)
    }
    
    private func configTitle() {
        let mode = MoviesManager.shared.getCurrentMode()
        self.navigationItem.title = NSLocalizedString(mode , comment: mode)
    }
    
    @objc func updateUI(){
        DispatchQueue.main.async {
            self.viewModel.config(navigationItems: self.navigationItem)
            self.tableView.reloadData()
            self.configTitle()
            if self.tableView.numberOfRows(inSection: 0) != 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self, name: .newDataObtained, object: nil)
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let width = self.view.frame.size.width
        return self.viewModel.getHeaderHeght(forWidth: width)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let width = self.view.frame.size.width
        return self.viewModel.getFooterHeight(forWidth: width)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieListHeader" ) as? MovieListHeader
            else {
                return UITableViewHeaderFooterView(frame: CGRect.zero)
        }
        headerView.searchBar.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieListTableViewFooter") as? MovieListTableViewFooter
            else { return  UITableViewHeaderFooterView(frame: CGRect.zero)
        }
        
        self.viewModel.config(footer: footer)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell
            else {
                return UITableViewCell(frame: CGRect.zero)
        }
        self.viewModel.config(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MoviesManager.shared.chooseMovie(withIndex: indexPath.row)
        self.performSegue(withIdentifier: "showMovieInfo", sender: nil)
    }
}

extension MovieListVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        MoviesManager.shared.changeMode(newMode: .all)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let string = searchBar.text,
        string.count > 2
            else {
                return
        }
        
        MoviesManager.shared.search(string)
    }
    
}
