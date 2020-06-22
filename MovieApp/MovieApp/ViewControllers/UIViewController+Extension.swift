//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 22/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instance<T: UIViewController>(from storyboardName: String, controllerIdentifier: String = String(describing: T.self)) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: controllerIdentifier) as? T else {
            fatalError("Could not instantiate \(controllerIdentifier)")
        }
        return viewController
    }
    
    static func instanceFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: T.self), bundle: nil)
    }
}
