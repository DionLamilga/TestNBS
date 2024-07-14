//
//  Constant.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import UIKit

enum ApiMovie: String {
    case popular = "/popular"
    case nowplaying = "/now_playing"
    case upcoming = "/upcoming"
    case torated = "/top_rated"

    func url() -> String {
        return "https://api.themoviedb.org/3/movie\(self.rawValue)"
    }
}

enum ImageMovie: String {
    case urlImage = "https://image.tmdb.org/t/p/original/"
}
