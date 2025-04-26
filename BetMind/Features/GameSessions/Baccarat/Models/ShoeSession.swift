//
//  ShoeSession.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

struct ShoeSession: Identifiable, Codable {
    let id: UUID
    let hands: [BaccaratHand]
    let date: Date
    let bankerPercentage: Double
    let playerPercentage: Double
    let tiePercentage: Double

    init(hands: [BaccaratHand]) {
        self.id = UUID()
        self.hands = hands
        self.date = Date()
        
        let total = hands.count
        let bankerCount = hands.filter { $0.result == .banker }.count
        let playerCount = hands.filter { $0.result == .player }.count
        let tieCount = hands.filter { $0.result == .tie }.count

        self.bankerPercentage = total > 0 ? (Double(bankerCount) / Double(total)) * 100 : 0
        self.playerPercentage = total > 0 ? (Double(playerCount) / Double(total)) * 100 : 0
        self.tiePercentage = total > 0 ? (Double(tieCount) / Double(total)) * 100 : 0
    }
}
