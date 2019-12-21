//
//  MovieInfoVC.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieInfoVC: UIViewController {

    private var viewModel: MovieInfoViewModel!
    private var favorite: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        if self.favorite {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-star")
            MoviesManager.shared.removeMovieFromFavorites()
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-star_filled")
            MoviesManager.shared.makeMovieFavorite()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = MoviesManager.shared.getChoosenMovie()
            else {
                self.dismiss(animated: false, completion: nil)
                return
        }
        self.viewModel = MovieInfoViewModel(withFrame: self.view.frame, movie: movie)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.viewModel.config(collectionView: self.collectionView)
        self.favorite = self.viewModel.config(navigationItem: self.navigationItem)
    }
}

extension MovieInfoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            viewForSupplementaryElementOfKind kind: String,
                            at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeader", for: indexPath) as? CollectionHeader
            else {
                return UICollectionReusableView()
        }
        self.viewModel.config(header: header)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        return self.viewModel.getCell(forCollection: self.collectionView, withIndexPath: indexPath)
    }
    
}

extension MovieInfoVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.viewModel.getHeightForHeader()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.getSizeForCell(withIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
