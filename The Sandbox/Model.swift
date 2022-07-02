//
//  Model.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 02.07.2022.
//

import Foundation

final class Model: NSObject {
    
    static var shared = Model()
    
    var documents: [Document] = [
    
        Document(image: "img_1" , name: "Это ведёрко", description: "сюда нужно сыпать песок"),
        Document(image: "img_2" , name: "Это лопатка", description: "нужны для насыпания"),
        Document(image: "img_3" , name: "Это грабельки", description: "для культивации песка"),
    
    ]
}
