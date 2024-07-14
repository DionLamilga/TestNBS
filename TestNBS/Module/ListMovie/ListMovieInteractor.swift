// 
//  ListMovieInteractor.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import Foundation
import RxSwift

class ListMovieInteractor {
    
    func fetchMovie() -> Observable<MovieDatas> {
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")
                ]
        return APIService.fetchData(from: ApiMovie.nowplaying.url(), model: MovieDatas.self, queryItems: queryItems)
    }
}
