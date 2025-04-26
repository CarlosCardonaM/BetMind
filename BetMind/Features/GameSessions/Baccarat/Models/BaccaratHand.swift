//
//  BaccaratHand.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

enum BaccaratResult: String, Identifiable, CaseIterable {
    case banker = "Banker"
    case player = "Player"
    case tie = "Tie"
    
    var id: String { rawValue }
}

struct BaccaratHand: Identifiable {
    let id = UUID()
    let result : BaccaratResult
    let timestamo: Date
}
