//
//  SportsContainerView.swift
//  BetMind
//
//  Created by Carlos Cardona on 28/04/25.
//

import SwiftUI

struct SportsContainerView: View {
    
    @State private var didCompleteFollowSetup: Bool = UserDefaults.standard.bool(forKey: "didCompleteFollowSetup")
    @State private var showingFollowSetup: Bool = false
    
    var body: some View {
        SportsHomeView()
            .onAppear {
                if !didCompleteFollowSetup {
                    showingFollowSetup = true
                }
            }
            .fullScreenCover(isPresented: $showingFollowSetup) {
                SportsFollowSetupView(onCompleted: {
                    didCompleteFollowSetup = true
                    UserDefaults.standard.set(true, forKey: "didCompleteFollowSetup")
                    showingFollowSetup = false
                })
            }
    }
}

#Preview {
    SportsContainerView()
}
