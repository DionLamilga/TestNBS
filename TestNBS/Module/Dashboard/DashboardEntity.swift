// 
//  DashboardEntity.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import Foundation

struct MovieDatas: Codable {
    var page: Int?
    var results: [MovieDetails]?
}

struct MovieDetails: Codable, Equatable, Hashable {
    var title,
        overview,
        date,
        image,
        backdrop: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case date = "release_date"
        case image = "poster_path"
        case backdrop = "backdrop_path"
    }
    
    static func == (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
