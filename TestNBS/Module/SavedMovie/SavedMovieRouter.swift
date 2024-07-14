// 
//  SavedMovieRouter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

class SavedMovieRouter {
    
    func showView() -> SavedMovieView {
        let interactor = SavedMovieInteractor()
        let presenter = SavedMoviePresenter(interactor: interactor)
        
        let storyboardId = String(describing: SavedMovieView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? SavedMovieView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
}
