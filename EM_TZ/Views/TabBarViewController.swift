//
//  TabBarViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var networkService = NetworkService()
    private lazy var homeViewModel = HomeViewModel(networkService: networkService)
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         generateTabBar()
     }
    
    override func viewDidLayoutSubviews() {
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: HomeViewController(viewModel: homeViewModel),
                image: UIImage(named: "home")
            ),
            generateVC(
                viewController: UIViewController(),
                image: UIImage(named: "favourites")
            ),
            generateVC(
                viewController: UIViewController(),
                image: UIImage(named: "cart")
            ),
            generateVC(
                viewController: UIViewController(),
                image: UIImage(named: "chat")
            ),
            generateVC(
                viewController: UIViewController(),
                image: UIImage(named: "profile")
            ),
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        let nc = UINavigationController(rootViewController: viewController)
        return nc
    }
    
    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.backgroundColor = UIColor.tabBar
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        tabBar.selectionIndicatorImage = .init(named: "backgroundCircle")
        
        tabBar.bounds = .init(x: tabBar.bounds.minX,
                              y: tabBar.bounds.minY,
                              width: tabBar.bounds.width,
                              height: tabBar.bounds.height + 13)
    }
}
