//
//  OnboardingPageView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: page.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
                .foregroundColor(.accentColor)
            
            Text(page.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingPageView(page: OnboardingPage(
        title: "Welcome",
        description: "Your AI Assistent for bets",
        systemImageName: "brain.head.profile"
    ))
}
