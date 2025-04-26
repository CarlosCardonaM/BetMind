//
//  AISuggestion.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

enum ConfidenceLevel: String, Equatable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct AISuggestion: Equatable {
    let message: String
    let confidence: ConfidenceLevel
}
