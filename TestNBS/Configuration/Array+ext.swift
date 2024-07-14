//
//  Array+ext.swift
//  TestNBS
//
//  Created by Dion Lamilga on 14/07/24.
//

import Foundation

extension Array where Element == MovieDetails {
    func removingDuplicates() -> [MovieDetails] {
        var seenTitle = Set<String>()
        return self.filter { (movie: MovieDetails) -> Bool in
            guard !seenTitle.contains(movie.title ?? "") else {
                return false
            }
            seenTitle.insert(movie.title ?? "")
            return true
        }
    }
}
