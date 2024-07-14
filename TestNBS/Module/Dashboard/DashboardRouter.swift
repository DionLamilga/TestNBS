// 
//  DashboardRouter.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import UIKit

class DashboardRouter {
    
    func showView() -> DashboardView {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(interactor: interactor)
        
        let storyboardId = String(describing: DashboardView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? DashboardView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
    
}
