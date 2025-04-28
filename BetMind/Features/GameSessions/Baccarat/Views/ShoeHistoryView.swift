//
//  ShowHistoryView.swift
//  BetMind
//
//  Created by Carlos Cardona on 27/04/25.
//

import SwiftUI

struct ShoeHistoryView: View {
    
    @State private var sessions: [ShoeSession] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if sessions.isEmpty {
                        Spacer()
                        Text("No shoes registered yet.")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(sessions) { session in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(formattedDate(session.date))
                                        .font(.headline)

                                    HStack(spacing: 24) {
                                        statItem(title: "Banca", value: session.bankerPercentage, highlight: isHighest(session.bankerPercentage, session))
                                        statItem(title: "Jugador", value: session.playerPercentage, highlight: isHighest(session.playerPercentage, session))
                                        statItem(title: "Empate", value: session.tiePercentage, highlight: isHighest(session.tiePercentage, session))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
                                .padding(.horizontal)                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Historial")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadSessions()
            }
        }
    }
    
    private func loadSessions() {
        sessions = ShoeSessionManager.shared.loadSessions().sorted(by: { $0.date > $1.date })
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func statItem(title: String, value: Double, highlight: Bool) -> some View {
        VStack {
            Text(title)
                .font(.caption)

            Text(String(format: "%.1f%%", value))
                .font(.headline.bold())
                .foregroundColor(highlight ? .blue : .primary)
        }
    }
    
    private func isHighest(_ value: Double, _ session: ShoeSession) -> Bool {
        let maxValue = max(session.bankerPercentage, session.playerPercentage, session.tiePercentage)
        return value == maxValue && maxValue > 0
    }
}

#Preview {
    ShoeHistoryView()
}
