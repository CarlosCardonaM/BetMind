//
//  BetMindApp.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

@main
struct BetMindApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
