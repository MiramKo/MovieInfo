//
//  MovieInfoViewModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class MovieInfoViewModel {
    
    private let frame: CGRect
    private let movie: Movie
    
    init(withFrame: CGRect, movie: Movie) {
        self.frame = withFrame
        self.movie = movie
    }
    
    public func config(collectionView: UICollectionView) {
        let headerNib = UINib(nibName: "CollectionHeader", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeader")
        
        let movieInfoCellNib = UINib(nibName: "MovieInfoCell", bundle: nil)
        collectionView.register(movieInfoCellNib, forCellWithReuseIdentifier: "MovieInfoCell")
        
        let genresCellNib = UINib(nibName: "GenresCell", bundle: nil)
        collectionView.register(genresCellNib, forCellWithReuseIdentifier: "GenresCell")
        
        let overviewCellNib = UINib(nibName: "OverviewCell", bundle: nil)
        collectionView.register(overviewCellNib, forCellWithReuseIdentifier: "OverviewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionView.collectionViewLayout = layout
        collectionView.alwaysBounceVertical = true
    }
    
    public func getNumberOfItems() -> Int {
        return 3
    }
    
    public func getHeightForHeader() -> CGSize {
        let height = self.frame.width * 0.580
        return CGSize(width: self.frame.width, height: height)
    }
    
    public func config(header: CollectionHeader) {
        let backdropImageManager = ImageManager(forImageType: .backdrop, withAdress: self.movie.backdropPath ?? "")
        let posterImageManager = ImageManager(forImageType: .poster, withAdress: self.movie.posterPath ?? "")
        
        backdropImageManager.setImage(forView: header.backdrop)
        posterImageManager.setImage(forView: header.poster)
    }
    
    public func config(navigationItem item: UINavigationItem) -> Bool {
        guard CDMovie.getMovie(withID: self.movie.id) != nil
            else {
                item.rightBarButtonItem?.image = UIImage(named: "icons8-star")
                return false
        }
        
        item.rightBarButtonItem?.image = UIImage(named: "icons8-star_filled")
        return true
    }
    
    public func getSizeForCell(withIndex index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize.init(width: self.frame.width, height: 150)
        case 1:
            return self.getHeightForGenres()
        case 2:
            return self.getHeightFreOverview()
        default:
            return CGSize.init(width: self.frame.width, height: 150)
        }
    }
    
    private func getHeightForGenres() -> CGSize {
        let genres = CDGenre.getValues(forIDS: self.movie.genreIds)
        if !genres.isEmpty {
            let genresString = (genres.keys.joined(separator: ",") + ".").capitalizingFirstLetter()
            let font = UIFont.systemFont(ofSize: 13.0)
            let titleConstraintsHeight: CGFloat = 40.0
            let height = genresString.height(withConstrainedWidth: self.frame.width, font: font) + titleConstraintsHeight
            
            return CGSize.init(width: self.frame.width, height: height)
        } else {
            return CGSize.init(width: self.frame.width, height: 0.01)
        }
    }
    
    private func getHeightFreOverview() -> CGSize {
        let font = UIFont.systemFont(ofSize: 15.0)
        let titleConstraintsHeight: CGFloat = 50.0
        let height = self.movie.overview.height(withConstrainedWidth: self.frame.width, font: font) + titleConstraintsHeight
        
        return CGSize.init(width: self.frame.width, height: height)
    }
    
    public func getCell(forCollection collection: UICollectionView, withIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "MovieInfoCell", for: indexPath) as? MovieInfoCell
            return self.configMovieInfoCell(cell)
        case 1:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as? GenresCell
            return self.configGenresCell(cell)
        case 2:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "OverviewCell", for: indexPath) as? OverviewCell
            return self.configOverviewCell(cell)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func configMovieInfoCell(_ cell: MovieInfoCell?) -> UICollectionViewCell {
        guard let cell = cell
            else {
                return UICollectionViewCell()
        }
        
        cell.date.text = self.movie.releaseDate
        cell.title.text = self.movie.title
        cell.originalTitle.text = self.movie.originalTitle
        
        cell.movieInfoCellTitle.text = NSLocalizedString("MOVIE_INFO_CELL_TITLE", comment: "MOVIE_INFO_CELL_TITLE")
        cell.movieInfoCellOriginalTitle.text = NSLocalizedString("MOVIE_INFO_CELL_ORIGINAL_TITLE", comment: "MOVIE_INFO_CELL_ORIGINAL_TITLEE")
        cell.movieInfoCellDate.text = NSLocalizedString("MOVIE_INFO_CELL_RELEASE_DATE", comment: "MOVIE_INFO_CELL_RELEASE_DATE")
        
        return cell
    }
    
    private func configGenresCell(_ cell: GenresCell?) -> UICollectionViewCell {
        guard let cell = cell
            else {
                return UICollectionViewCell()
        }
        
        let genres = CDGenre.getValues(forIDS: self.movie.genreIds)
        let genresString = (genres.keys.joined(separator: ",") + ".").capitalizingFirstLetter()
        
        if !genres.isEmpty {
            cell.genresCellTitle.text = NSLocalizedString("GENRES_CELL_TITLE", comment: "GENRES_CELL_TITLE")
            cell.genres.text = genresString
        }
        
        return cell
    }
    
    private func configOverviewCell(_ cell: OverviewCell?) -> UICollectionViewCell {
        guard let cell = cell
            else {
                return UICollectionViewCell()
        }

        cell.overview.text = self.movie.overview
        cell.overviewCellTitle.text = NSLocalizedString("OVERVIEW_CELL_TITL", comment: "OVERVIEW_CELL_TITL")
        
        return cell
    }
    
}
