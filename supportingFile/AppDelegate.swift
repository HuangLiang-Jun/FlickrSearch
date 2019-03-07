//
//  AppDelegate.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/6.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        setup()
        return true
    }
    
    func setup() {
        
        let searchNV = UINavigationController(rootViewController: SearchViewController())
        searchNV.tabBarItem.image = UIImage(named: "unselected")!
        searchNV.tabBarItem.title = "Search"
        
        let favoriteNV = UINavigationController(rootViewController: FavoriteViewController())
        favoriteNV.tabBarItem.image = UIImage(named: "unselected")!
        favoriteNV.tabBarItem.title = "Favorite"
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers([searchNV, favoriteNV], animated: false)
        tabbarController.view.backgroundColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
    }

}

