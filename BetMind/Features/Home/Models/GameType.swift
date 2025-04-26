//
//  GameType.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import Foundation

enum GameType: String, CaseIterable, Identifiable {
    case baccarat = "Baccarat"
    case blackjack = "BlackJack"
    case roulette = "Roulette"
    case sports = "Sports"
    
    var id: String { rawValue }
    
    var name: String {
        rawValue
    }
}
