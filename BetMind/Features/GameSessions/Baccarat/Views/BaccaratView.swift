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
    @State private var currentSuggestion: AISuggestion? = nil
    @State private var showFinishAlert: Bool = false
    
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
        ScrollView {
            VStack(spacing: 24) {
                Text("Registrar mano")
                    .font(.largeTitle.bold())
                    .padding(.top)

                if let suggestion = currentSuggestion {
                    VStack(spacing: 8) {
                        Text("Sugerencia Inteligente")
                            .font(.headline)
                        Text(suggestion.message)
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                        Text("Confianza: \(suggestion.confidence.rawValue)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .transition(.opacity.combined(with: .scale))
                    .animation(.easeInOut(duration: 0.4), value: currentSuggestion)
                }

                HStack(spacing: 16) {
                    ForEach(BaccaratResult.allCases) { result in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                registerHand(result)
                            }
                        }) {
                            Text(result.rawValue)
                                .font(.headline)
                                .frame(width: 100, height: 100)
                                .background(backgroundColor(for: result))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                                .scaleEffect(0.95)
                                .animation(.easeOut(duration: 0.2), value: hands.count)
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

                Divider()

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 10), spacing: 4) {
                    ForEach(hands.reversed()) { hand in // <- Reversamos aquí
                        ZStack {
                            Circle()
                                .fill(backgroundColor(for: hand.result))
                                .frame(width: 20, height: 20)
                            Text(initial(for: hand.result))
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
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
                .alert("¿Nuevo Zapato?", isPresented: $showResetAlert) {
                    Button("Confirmar", role: .destructive) {
                        resetShoe()
                    }
                    Button("Cancelar", role: .cancel) {}
                } message: {
                    Text("¿Estás seguro que quieres empezar un nuevo zapato? Esto borrará el historial actual.")
                }
                
                Button(action: {
                    finishShoe()
                }) {
                    Text("Finalizar Zapato")
                        .font(.subheadline.bold())
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.bottom, 8)
                
                
            }
            .padding()
        }
        .alert("Zapato Finalizado", isPresented: $showFinishAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("La sesión ha sido guardada exitosamente.")
        }
    }
    
    private func registerHand(_ result: BaccaratResult) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        
        let hand = BaccaratHand(result: result, timestamo: Date())
        hands.append(hand)
        
        withAnimation(.easeInOut(duration: 0.4)) {
            currentSuggestion = AIManager.shared.generateSuggestion(for: .baccarat, state: hands)
        }
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
    
    private func finishShoe() {
        guard !hands.isEmpty else { return }

        let session = ShoeSession(hands: hands)
        ShoeSessionManager.shared.saveSession(session)

        hands.removeAll()
        currentSuggestion = nil
        showFinishAlert = true
    }
}

#Preview {
    BaccaratView()
}
