//
//  AppDelegate.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let documentsViewController = DocumentsViewController()
        let documentsNavigationController = UINavigationController(rootViewController: documentsViewController)
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .lightGray

                
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = .lightGray
        
        let appearanceTabBar = tabBarController.tabBar.standardAppearance
        appearanceTabBar.stackedLayoutAppearance.selected.iconColor = .brown
        tabBarController.tabBar.standardAppearance = appearanceTabBar
//
        documentsNavigationController.tabBarItem = UITabBarItem(
            title: "Documents",
            image: UIImage(systemName: "doc.on.doc"),
            selectedImage: UIImage(systemName: "doc.on.doc.fill"))

        documentsNavigationController.navigationBar.topItem?.title = "My documents"
//        documentsNavigationController.navigationBar.barTintColor = .lightGray
        documentsNavigationController.navigationBar.standardAppearance = appearanceNavigationBar
//        documentsNavigationController.navigationBar.scrollEdgeAppearance = documentsNavigationController.navigationBar.standardAppearance
        documentsNavigationController.navigationBar.topItem?.rightBarButtonItem?.tintColor = .brown
        
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.2"),
            selectedImage: UIImage(systemName:"gearshape.2.fill"))
        settingsNavigationController.navigationBar.topItem?.title = "Settings"
//        settingsNavigationController.navigationBar.barTintColor = Colors.navigationBarColor
        settingsNavigationController.navigationBar.standardAppearance = appearanceNavigationBar
        settingsNavigationController.navigationBar.scrollEdgeAppearance = settingsNavigationController.navigationBar.standardAppearance

        tabBarController.viewControllers = [documentsNavigationController, settingsNavigationController]
                        
        window?.rootViewController = tabBarController
                
        window?.makeKeyAndVisible()
        
        return true
    }



}

