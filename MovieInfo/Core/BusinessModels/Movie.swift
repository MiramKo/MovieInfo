//
//  Movie.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    let popularity: Double
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title: String
    let releaseDate: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let posterPath: String?
}
