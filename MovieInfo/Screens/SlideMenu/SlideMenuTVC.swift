//
//  SlideMenuTVC.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class SlideMenuTVC: UIViewController {

    private var viewModel: SlideMenuViewModel!
    private var tableView: UITableView!
    private weak var menuButtonsDelegate: MenuButtonTappedDelegate?
    private var alphaView: UIView!
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.closeMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuButtonsDelegate = SlideMenuCoordinator.shared
        self.configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.animate(tableView: self.tableView) {  }
    }
    
    private func configViews() {
        self.viewModel = SlideMenuViewModel()
        let frameRect = self.view.frame
        
        self.alphaView = viewModel.createalphaView(withFrame: frameRect)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(alphaViewTapped))
        gesture.isEnabled = true
        gesture.cancelsTouchesInView = false
        self.alphaView.addGestureRecognizer(gesture)
        self.view.addSubview(alphaView)
        
        self.tableView = self.viewModel.createTableView(withFrame: frameRect)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.viewModel.config(superView: self.view)
        
    }
    
    @objc func alphaViewTapped() {
        self.closeMenu()
    }
    
    private func closeMenu() {
        self.viewModel.animate(tableView: self.tableView) { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }
    }
}

extension SlideMenuTVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SlideMenuCell", for: indexPath) as? SlideMenuCell else { return UITableViewCell() }
        
        return self.viewModel.config(cell: cell, forIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuButtonsDelegate?.tappedButton(withIndex: indexPath.row)
        self.viewModel.animate(tableView: self.tableView) { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }
    }
}
