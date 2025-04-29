//
//  SportsHomeView.swift
//  BetMind
//
//  Created by Carlos Cardona on 28/04/25.
//

import SwiftUI

struct SportsHomeView: View {
    
    @StateObject private var viewModel = SportsHomeViewModel()
    
    private var groupedMatches: [(date: Date, matches: [SportsMatch])] {
        let grouped = Dictionary(grouping: viewModel.matches) { match in
            Calendar.current.startOfDay(for: match.startTime)
        }
        return grouped
            .map { ($0.key, $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    Color.clear
                        .frame(height: 16)
                    ForEach(groupedMatches, id: \.date) { (date, matches) in
                        VStack(alignment: .leading, spacing: 12) {
                            dateTitle(for: date)
                                .padding(.horizontal)
                            
                            ForEach(matches) { match in
                                matchCard(match)
                            }
                        }
                    }
                }
                .padding(8)
            }
            .navigationTitle("Matches")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(uiColor: .systemBackground), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private func dateTitle(for date: Date) -> some View {
        let text: String
            if Calendar.current.isDateInToday(date) {
                text = "Hoy"
            } else if Calendar.current.isDateInYesterday(date) {
                text = "Ayer"
            } else if Calendar.current.isDateInTomorrow(date) {
                text = "Mañana"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE d MMM"
                text = formatter.string(from: date).capitalized
            }

            return HStack {
                Text(text)
                    .font(.title3.bold())
                if Calendar.current.isDateInToday(date) {
                    Text("Hoy")
                        .font(.caption2.bold())
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(6)
                        .foregroundColor(.blue)
                }
            }
    }
    
    private func matchCard(_ match: SportsMatch) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(match.league)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        if let logo = match.homeTeamLogoName {
                            Image(systemName: logo)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                        }
                        Text(match.homeTeam)
                            .font(.headline)
                    }
                    
                    HStack {
                        if let logo = match.awayTeamLogoName {
                            Image(systemName: logo)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                        }
                        Text(match.awayTeam)
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                VStack {
                    if let score = match.score, match.status != .upcoming {
                        Text(score)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    } else {
                        Text(stratTimeFormatted(match.startTime))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    statusText(match.status)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private func stratTimeFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func statusText(_ status: MatchStatus) -> some View {
        let (text, color): (String, Color) = {
            switch status {
            case .live:
                return ("En Vivo", .green)
            case .upcoming:
                return ("Próximo", .gray)
            case .finished:
                return ("Finalizado", .red)
            }
        }()

        return Text(text)
            .font(.caption.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.2))
            .cornerRadius(6)
            .foregroundColor(color)
    }
    

}

#Preview {
    SportsHomeView()
}
