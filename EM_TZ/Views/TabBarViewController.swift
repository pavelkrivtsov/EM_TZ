//
//  TabBarViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .red
        
        viewControllers = [
            createNavigationController(rootViewController: UIViewController(), title: "Home"),
            createNavigationController(rootViewController: UIViewController(), title: "Favourites"),
            createNavigationController(rootViewController: UIViewController(), title: "Shopping cart"),
            createNavigationController(rootViewController: UIViewController(), title: "Chat"),
            createNavigationController(rootViewController: UIViewController(), title: "Profile"),
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        rootViewController.view.backgroundColor = .white
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
}
