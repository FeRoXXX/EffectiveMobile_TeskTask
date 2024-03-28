//
//  NavigationViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setRootViewController(rootViewController: UIViewController) {
        viewControllers = [rootViewController]
    }
}
