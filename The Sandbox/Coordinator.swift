//
//  Coordinator.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 07.07.2022.
//

import Foundation
import UIKit

enum AuthState {
    case signUp
    case signIn
    case editPass
}

final class Coordinator {
    
//    let navigationcontroller: UINavigationController
////    let authState: AuthState?
//
//    init(
//        navigationController: UINavigationController
////        state: AuthState
//    ) {
//        self.navigationcontroller = navigationController
////        self.authState = state
//    }

    
    public func showDetail(state: AuthState, navCon: UINavigationController?) {
        
        let viewController: UIViewController
        viewController.modalPresentationStyle = .fullScreen
        
        switch state {
        case .signUp:
            viewController = AuthViewController(state: .signUp)
        case .signIn:
            viewController = AuthViewController(state: .signIn)
        case .editPass:
            viewController = AuthViewController(state: .editPass)
        }
        navCon?.present(viewController, animated: true)
    }

    public func pop(navCon: UINavigationController?) {
        navCon?.popViewController(animated: true)
    }
}
