//
//  AIEngine.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

protocol AIEngine {
    associatedtype GameState
    
    func generateSuggestion(from state: GameState) -> AISuggestion
}
