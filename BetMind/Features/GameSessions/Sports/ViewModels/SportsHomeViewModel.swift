//
//  SportsHomeViewModel.swift
//  BetMind
//
//  Created by Carlos Cardona on 28/04/25.
//

import Foundation

class SportsHomeViewModel: ObservableObject {
    
    @Published var matches: [SportsMatch] = []
    
    init() {
        loadDummyMatches()
    }
    
    private func loadDummyMatches() {
        // Aquí metemos partidos de ejemplo para hoy, ayer y mañana
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        matches = [
            SportsMatch(homeTeam: "Real Madrid", awayTeam: "Barcelona", league: "La Liga", startTime: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, status: .live, score: "2-1", homeTeamLogoName: "shield", awayTeamLogoName: "shield"),
            SportsMatch(homeTeam: "Lakers", awayTeam: "Warriors", league: "NBA", startTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, status: .upcoming, score: nil, homeTeamLogoName: "shield", awayTeamLogoName: "shield"),
            SportsMatch(homeTeam: "Yankees", awayTeam: "Red Sox", league: "MLB", startTime: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, status: .finished, score: "5-3", homeTeamLogoName: "shield", awayTeamLogoName: "shield"),
            SportsMatch(homeTeam: "Bravos", awayTeam: "Pericos", league: "LMB", startTime: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, status: .finished, score: "1-3", homeTeamLogoName: "shield", awayTeamLogoName: "shield")
        ]
    }
}
