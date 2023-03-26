//
//  TabBarViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var coordinator: AppCoordinatorProtocol
    
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                viewController: HomeViewController(viewModel: HomeViewModel(networkService: NetworkService())),
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
                viewController: ProfileAssembly.assemble(coordinator),
                image: UIImage(named: "profile")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        viewController.view.backgroundColor = .white
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
