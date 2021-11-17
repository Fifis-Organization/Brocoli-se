//
//  Endpoints.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 14/11/21.
//

import Foundation

protocol EndpointsProtocol {
    var baseURL: String { get }
    var path: String { get }
}

enum Endpoints: EndpointsProtocol {
    
    case getRecipes
    
    var baseURL: String {
        switch self {
        case .getRecipes:
            return "https://brocolise-receita.herokuapp.com/"
        }
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "receitas"
        }
    }
    
}
