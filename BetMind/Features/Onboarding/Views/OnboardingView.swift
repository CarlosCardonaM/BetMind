//
//  OnboardingView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var currentPage = 0
    
    private let pages = [
        OnboardingPage(title: "Registra tus jugadas", description: "Lleva el control de cada jugada en Baccarat, Blackjack, Ruleta y Deportes", systemImageName: "list.bullet.rectangle.portrait"),
        OnboardingPage(title: "Recibe sugerencias inteligentes", description: "Usa estrategias probadas y mejora tus decisiones.", systemImageName: "sparkles"),
        OnboardingPage(title: "Analiza tu progreso", description: "Consulta estadísticas de tu juego y toma mejores decisiones.", systemImageName: "chart.bar.xaxis")
    ]
    
    var body: some View {
        
        VStack(spacing: 32) {
            
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    OnboardingPageView(page: page)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            
            Spacer()
            
            if currentPage == pages.count - 1 {
                Button(action: {
                    hasSeenOnboarding = true
                }) {
                    Text("Let's Begin!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: currentPage)
    }
}

#Preview {
    OnboardingView()
}
