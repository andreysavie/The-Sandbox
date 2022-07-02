//
//  Model.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import Foundation

final class Model: NSObject {
    
    static let shared = Model()
    
    public var images = (1...3).compactMap {"img_\($0)"}

}
