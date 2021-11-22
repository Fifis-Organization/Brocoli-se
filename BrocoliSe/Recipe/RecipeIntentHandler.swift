//
//  RecipeIntentHandler.swift
//  Recipe
//
//  Created by Paulo Uchôa on 20/11/21.
//

import Foundation
import Intents

class RecipeIntentHandler: NSObject, RecipeIntentHandling {
    
    func handle(intent: RecipeIntent, completion: @escaping (RecipeIntentResponse) -> Void) {
        completion(RecipeIntentResponse.success(result: intent.name ?? "nome"))
    }
    
    func resolveName(for intent: RecipeIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if intent.name == "nome" {
            completion(INStringResolutionResult.needsValue())
        } else {
            completion(INStringResolutionResult.success(with: intent.name ?? ""))
        }
    }
}
