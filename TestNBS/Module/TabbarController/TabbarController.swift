//
//  TabbarController.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
    
    func setupTab() {
        let dashboard = navigationHandler(image: "house", view: DashboardRouter().showView())
        let list = navigationHandler(image: "medal", view: ListMovieRouter().showView())
        let saved = navigationHandler(image: "heart", view: SavedMovieRouter().showView())
        self.tabBar.tintColor = .orange
        self.setViewControllers([dashboard, list, saved], animated: true)
    }
    
    func navigationHandler(image: String, view: UIViewController) -> UINavigationController {
        let navItem = UINavigationController(rootViewController: view)
        navItem.tabBarItem.image = UIImage(systemName: image)
        return navItem
    }
}
