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
        
        window?.rootViewController = documentsNavigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

