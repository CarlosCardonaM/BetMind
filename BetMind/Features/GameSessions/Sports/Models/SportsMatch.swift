//
//  SportsMatch.swift
//  BetMind
//
//  Created by Carlos Cardona on 28/04/25.
//

import Foundation

enum MatchStatus: String, Codable {
    case live
    case upcoming
    case finished
}

struct SportsMatch: Identifiable, Codable {
    var id = UUID()
    let homeTeam: String
    let awayTeam: String
    let league: String
    let startTime: Date
    let status: MatchStatus
    let score: String?
    let homeTeamLogoName: String?
    let awayTeamLogoName: String?
}
