//
//  StringExtension.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 21/09/21.
//

import Foundation

extension String {
    func iconTable() -> String {
        switch self {
        case FoodNames.carne:
            return IconNames.carne
        case FoodNames.ovos:
            return IconNames.ovos
        case FoodNames.leite:
            return IconNames.leite
        case FoodNames.frango:
            return IconNames.frango
        case FoodNames.peixe:
            return IconNames.peixe
        default:
            return ""
        }
    }
}
