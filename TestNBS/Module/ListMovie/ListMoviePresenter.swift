// 
//  ListMoviePresenter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import Foundation
import RxSwift
import RxRelay

class ListMoviePresenter {
    
    private let interactor: ListMovieInteractor
    private let router = ListMovieRouter()
    
    var listMovie = BehaviorRelay<[MovieDetails]>(value: [])
    
    init(interactor: ListMovieInteractor) {
        self.interactor = interactor
    }
    
    var bag = DisposeBag()
    
    func fetchMovie() {
        interactor.fetchMovie()
            .subscribe(onNext: {[weak self] value in
                guard let self = self else {return}
                self.listMovie.accept(value.results ?? [])
            }).disposed(by: bag)
    }
    
}
