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
    
    public func showDetail(state: AuthState, navCon: UINavigationController?) {
        
        let viewController: UIViewController
        
        switch state {
        case .signUp:
            viewController = AuthViewController(state: .signUp)
        case .signIn:
            viewController = AuthViewController(state: .signIn)
        case .editPass:
            viewController = AuthViewController(state: .editPass)
        }
        viewController.modalPresentationStyle = .fullScreen
        navCon?.present(viewController, animated: true)
    }

    public func pop(navCon: UINavigationController?) {
        navCon?.popViewController(animated: true)
    }
}
