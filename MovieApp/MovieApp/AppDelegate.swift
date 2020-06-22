//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let homeViewController = HomeViewController.instance(from: "Main", controllerIdentifier: "HomeViewController") as? HomeViewController else {
             fatalError("Unable to instantiate an ViewController from the storyboard")
        }
        let viewModel = HomeViewModel()
        homeViewController.configWithViewModel(viewModel)
        let navigationController = UINavigationController.init(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

