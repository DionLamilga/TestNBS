// 
//  DashboardInteractor.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import Foundation
import RxSwift

class DashboardInteractor {
    func fetchMovie(urlMoview: ApiMovie) -> Observable<MovieDatas> {
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")
                ]
        var url = ""
        switch urlMoview {
        case .popular:
            url = ApiMovie.popular.url()
        case .nowplaying:
            url = ApiMovie.nowplaying.url()
        case .upcoming:
            url = ApiMovie.upcoming.url()
        case .torated:
            url = ApiMovie.torated.url()
        }
        
        return APIService.fetchData(from: url, model: MovieDatas.self, queryItems: queryItems)
    }
}
