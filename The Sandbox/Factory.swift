//
//  Factory.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 07.07.2022.
//

import Foundation
import UIKit

final class Factory {
    
    enum AuthState {
        case signUp
        case signIn
        case editPass
    }
    
    let navigationController: UINavigationController
    let authState: AuthState
    
    init(
        navigationController: UINavigationController,
        state: AuthState
    ) {
        self.navigationController = navigationController
        self.authState = state
        startModule()
    }
    
    func startModule() {
        switch authState {
            
        case .signUp:
            <#code#>
        case .signIn:
            <#code#>
        case .editPass:
            <#code#>
        }
        
    }
    
}
