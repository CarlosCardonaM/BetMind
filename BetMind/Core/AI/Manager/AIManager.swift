//
//  AIManager.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

enum GameTypeAI {
    case baccarat
    case blackjack
    case roulette
    case sports
}

final class AIManager {
    static let shared = AIManager() // Singleton para uso global
    
    private init() {}
    
    func generateSuggestion<GameState>(for gameType: GameTypeAI, state: GameState) -> AISuggestion {
        switch gameType {
        case .baccarat:
            if let baccaratState = state as? [BaccaratHand] {
                let engine = BaccaratAIEngine()
                return engine.generateSuggestion(from: baccaratState)
            }
        case .blackjack:
            // TODO: - En el futuro lo implementaremos
            return AISuggestion(message: "Motor de Blackjack aun no implementado", confidence: .low)
        case .roulette:
            return AISuggestion(message: "Motor de Roulette aun no implementado", confidence: .low)
        case .sports:
            return AISuggestion(message: "Motor de Sports aun no implementado", confidence: .low)
        }
        
        // Fallback seguro
        return AISuggestion(message: "Game not supported", confidence: .low)
    }
}
