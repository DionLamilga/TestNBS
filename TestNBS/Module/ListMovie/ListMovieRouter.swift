// 
//  ListMovieRouter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

class ListMovieRouter {
    
    func showView() -> ListMovieView {
        let interactor = ListMovieInteractor()
        let presenter = ListMoviePresenter(interactor: interactor)
        
        let storyboardId = String(describing: ListMovieView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? ListMovieView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
    
    //Navigate to other xib-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
    */
    
    //Navigate to other storyboard-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
     */
    
}
