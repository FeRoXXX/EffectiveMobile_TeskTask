//
//  TabBarController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        addSeparator()
    }
    
    private func setupTabBarItems() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        let dataManager = DataManager()
        let searchViewController = SearchViewController()
        searchViewController.dataManager = dataManager
        let searchController: UINavigationController = UINavigationController(rootViewController: searchViewController)
        searchController.setNavigationBarHidden(true, animated: true)
        searchController.title = "Поиск"
        searchController.tabBarItem.image = UIImage(named: "Search")
        let favoriteViewController = FavoritesViewController()
        favoriteViewController.dataManager = dataManager
        let favoritesController: UINavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoritesController.setNavigationBarHidden(true, animated: true)
        favoritesController.title = "Избранное"
        let image = UIImage(named: "Like")
        let customTabBarItem = UITabBarItem(title: "Избранное", image: image, selectedImage: nil)
        favoritesController.tabBarItem = customTabBarItem
        let responsesController = ResponsesViewController()
        responsesController.title = "Отклики"
        responsesController.tabBarItem.image = UIImage(named: "Response")
        let messagesController = MessagesViewController()
        messagesController.title = "Сообщения"
        messagesController.tabBarItem.image = UIImage(named: "Message")
        let profileController = ProfileViewController()
        profileController.title = "Профиль"
        profileController.tabBarItem.image = UIImage(named: "Profile")
        setViewControllers([searchController, favoritesController, responsesController, messagesController, profileController], animated: true)
        tabBar.barTintColor = UIColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1)
        tabBar.tintColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
        
    }
    
    private func addSeparator() {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5)
        topBorder.backgroundColor = CGColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1)
        tabBar.layer.addSublayer(topBorder)
    }

}
