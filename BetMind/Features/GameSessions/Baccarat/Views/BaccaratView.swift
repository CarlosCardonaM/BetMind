//
//  BaccaratView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

struct BaccaratView: View {
    
    @State private var hands: [BaccaratHand] = []
    @State private var showResetAlert: Bool = false
    
    private var totalHands: Int {
        hands.count
    }
    
    private var bankerPercentage: Double {
        let count = hands.filter { $0.result == .banker }.count
        return totalHands > 0 ? (Double(count) / Double(totalHands)) * 100 : 0
    }
    
    private var playerPercentage: Double {
        let count = hands.filter { $0.result == .player }.count
        return totalHands > 0 ? (Double(count) / Double(totalHands)) * 100 : 0
    }
    
    private var tiePercentage: Double {
        let count = hands.filter { $0.result == .tie }.count
        return totalHands > 0 ? (Double(count) / Double(totalHands)) * 100 : 0
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Register hand")
                .font((.largeTitle.bold()))
                .padding(.top)
            
            Button(action: {
                showResetAlert = true
            }) {
                Text("Nuevo Zapato")
                    .font(.subheadline.bold())
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.bottom, 8)
            .alert("Confirmar", isPresented: $showResetAlert) {
                Button("Confirm", role: .destructive) {
                    resetShoe()
                }
                Button("Canel", role: .cancel) { }
            } message: {
                Text("Are you sure you wnat to star over a new show?")
            }
            
            HStack(spacing: 16) {
                ForEach(BaccaratResult.allCases) { result in
                    Button(action: {
                        registerHand(result)
                    }) {
                        Text(result.rawValue)
                            .font(.headline)
                            .frame(width: 100, height: 100)
                            .background(backgroundColor(for: result))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
            
            Divider()
            
            VStack(spacing: 8) {
                Text("Estadísticas")
                    .font(.headline)
                HStack(spacing: 16) {
                    statItem(title: "Banca", value: bankerPercentage)
                    statItem(title: "Jugador", value: playerPercentage)
                    statItem(title: "Empate", value: tiePercentage)
                }
            }
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                    ForEach(hands) { hand in
                        ZStack {
                            Circle()
                                .fill(backgroundColor(for: hand.result))
                                .frame(width: 40, height: 40)
                            Text(initial(for: hand.result))
                                .font(.caption.bold())
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 300)
            
            Spacer()
        }
        .padding()
    }
    
    private func registerHand(_ result: BaccaratResult) {
        let hand = BaccaratHand(result: result, timestamo: Date())
        hands.append(hand)
    }
    
    private func backgroundColor(for result: BaccaratResult) -> Color {
        switch result {
        case .banker:
            return .red
        case .player:
            return .blue
        case .tie:
            return .green
        }
    }
    
    private func initial(for result: BaccaratResult) -> String {
        switch result {
        case .banker:
            return "B"
        case.player:
             return "P"
        case .tie:
             return "T"
        }
    }
    
    private func statItem(title: String, value: Double) -> some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(String(format: "%.1f%%", value))
                .font(.headline.bold())
        }
    }
    
    private func resetShoe() {
        hands.removeAll()
    }
}

#Preview {
    BaccaratView()
}
