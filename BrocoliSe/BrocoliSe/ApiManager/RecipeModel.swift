//
//  Recipe.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 14/11/21.
//

import Foundation

struct RecipeModel: Codable {
    let id, name, portions, time: String
    let ingredients, steps: [String]
    let pathPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case portions = "porcoes"
        case time = "tempo"
        case steps = "preparo"
        case ingredients = "ingredientes"
        case pathPhoto = "pathFoto"
    }
    
}
