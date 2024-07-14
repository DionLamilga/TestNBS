// 
//  SavedMoviePresenter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import Foundation
import RxCocoa

class SavedMoviePresenter {
    
    private let interactor: SavedMovieInteractor
    private let router = SavedMovieRouter()
    
    var savedMovie = BehaviorRelay<[MovieDetails]>(value: [])
    
    init(interactor: SavedMovieInteractor) {
        self.interactor = interactor
    }
    
}
