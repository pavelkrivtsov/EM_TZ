//
//  SceneDelegate.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        window?.rootViewController = SignInViewController()
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

