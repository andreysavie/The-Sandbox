//
//  MainTabBarController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 07.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: PROPERTIES =====================================================================
    
    static let appearanceNavigationBar: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        return appearance
    }()
    
    private lazy var documentsNavigationController: UINavigationController = {
        let navCon = UINavigationController(rootViewController: DocumentsViewController())
        navCon.tabBarItem = UITabBarItem(
            title: "Documents",
            image: UIImage(systemName: "doc.on.doc"),
            selectedImage: UIImage(systemName: "doc.on.doc.fill"))
        navCon.navigationBar.topItem?.title = "My documents"
        navCon.navigationBar.standardAppearance = MainTabBarController.appearanceNavigationBar
        navCon.navigationBar.scrollEdgeAppearance = navCon.navigationBar.standardAppearance
        return navCon
    }()
    

    private lazy var settingsNavigationController: UINavigationController = {
        let navCon = UINavigationController(rootViewController: SettingsViewController())
        navCon.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape.2"),
            selectedImage: UIImage(systemName:"gearshape.2.fill"))
        navCon.navigationBar.topItem?.title = "Settings"
        navCon.navigationBar.standardAppearance = MainTabBarController.appearanceNavigationBar
        navCon.navigationBar.scrollEdgeAppearance = navCon.navigationBar.standardAppearance
        return navCon
    }()
    
    private lazy var appearanceTabBar: UITabBarAppearance = {
        let appearance = self.tabBar.standardAppearance
        appearance.stackedLayoutAppearance.selected.iconColor = .brown
        return appearance
    }()

    //MARK: INITS =====================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        tabBar.backgroundColor = .white
        tabBar.tintColor = .lightGray
        tabBar.standardAppearance = appearanceTabBar
        viewControllers = [documentsNavigationController, settingsNavigationController]
        
//        let appearanceTabBar = tabBar.standardAppearance
//        tabBar.standardAppearance = appearanceTabBar
    }
    
}

