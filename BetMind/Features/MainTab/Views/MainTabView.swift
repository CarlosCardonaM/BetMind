//
//  MainTabView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle")
                }
        }
    }
}


#Preview {
    MainTabView()
}
