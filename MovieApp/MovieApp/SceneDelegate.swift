//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            guard let homeViewController = HomeViewController.instance(from: "Main", controllerIdentifier: "HomeViewController") as? HomeViewController else {
                 fatalError("Unable to instantiate an ViewController from the storyboard")
            }
            let viewModel = HomeViewModel()
            homeViewController.configWithViewModel(viewModel)
            let navigationController = UINavigationController.init(rootViewController: homeViewController)
            
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

