// 
//  DashboardPresenter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import UIKit
import RxSwift
import RxRelay

class DashboardPresenter {
    
    private let interactor: DashboardInteractor
    private let router = DashboardRouter()
    
    var listMoviePopular = BehaviorRelay<[MovieDetails]>(value: [])
    var listMovieUpcoming = BehaviorRelay<[MovieDetails]>(value: [])
    var topMovie = PublishSubject<[MovieDetails]>()
    
    var bag = DisposeBag()
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
    }
    
    func fetchMoviePopular() {
        interactor.fetchMovie(urlMoview: .popular)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else {return}
                self.listMoviePopular.accept(value.results ?? [])
            }).disposed(by: bag)
    }
    
    func fetchMovieUpcoming() {
        interactor.fetchMovie(urlMoview: .upcoming)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else {return}
                self.listMovieUpcoming.accept(value.results ?? [])
            }).disposed(by: bag)
    }
    
    func fetchTopMovie() {
        interactor.fetchMovie(urlMoview: .torated)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else {return}
                let topThreeMovies = Array(value.results?.prefix(3) ?? [])
                self.topMovie.onNext(topThreeMovies)
            }).disposed(by: bag)
    }
}
