//
//  BaccaratEngine.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

struct BaccaratAIEngine: AIEngine {
    typealias GameState = [BaccaratHand]
    
    func generateSuggestion(from state: [BaccaratHand]) -> AISuggestion {
        guard !state.isEmpty else {
            return AISuggestion(message: "Not enough data", confidence: .low)
        }
        
        // Analizar las ultimas 3 jugadas (o menos si no hay suficientes)
        let lastHands = state.suffix(3)
        
        // Contar cuantas veces se repite el mismo resultado
        let bankerCount = lastHands.filter { $0.result == .banker }.count
        let playerCount = lastHands.filter { $0.result == .player }.count
        let tieCount = lastHands.filter { $0.result == .tie }.count
        
        // Definir la sugerencia segun el patron
        if bankerCount >= 2 {
            return AISuggestion(message: "Banker", confidence: .high)
        } else if playerCount >= 2 {
            return AISuggestion(message: "Player", confidence: .high)
        } else if tieCount >= 2 {
            return AISuggestion(message: "Tie", confidence: .medium)
        } else {
            return AISuggestion(message: "There is not a clear trend. follow your strategy", confidence: .low)
        }
    }
}
