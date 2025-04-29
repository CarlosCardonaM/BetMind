//
//  MainTabView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

enum ModuleSelected {
    case baccarat
    case sports
}

struct MainTabView: View {
    
    @State private var selectedModule: ModuleSelected = .baccarat
    @State private var selectedGame: GameType = .baccarat
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TabView {
                    if selectedModule == .baccarat {
                        HomeView()
                            .tabItem {
                                Label("Inicio", systemImage: "house")
                            }
                        ShoeHistoryView()
                            .tabItem {
                                Label("Historial", systemImage: "clock")
                            }
                    } else if selectedModule == .sports {
                        SportsContainerView()
                            .tabItem {
                                Label("Partidos", systemImage: "sportscourt")
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    moduleSelectionMenu
                }
            }
        }
    }
    
    private var moduleSelectionMenu: some View {
        Menu {
            Button(action: {
                selectedModule = .baccarat
                selectedGame = .baccarat
            }) {
                Text("Baccarat")
            }
            Button(action: {
                selectedModule = .sports
                selectedGame = .sports
            }) {
                Text("Sports")
            }
        } label: {
            HStack(spacing: 4) {
                Text(selectedGame.name)
                    .font(.title)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
            }
        }
    }
}


//#Preview {
//    MainTabView()
//}
