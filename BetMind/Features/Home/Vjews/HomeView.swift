//
//  HomeView.swift
//  BetMind
//
//  Created by Carlos Cardona on 25/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedGame: GameType = .baccarat
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                Group {
                    switch selectedGame {
                    case .baccarat:
                        BaccaratView()
                    case .blackjack:
                        BlackJackView()
                    case .roulette:
                        RouletteView()
                    case .sports:
                        SportsView()
                    }
                }
                
                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        ForEach(GameType.allCases) { game in
                            Button(action: {
                                selectedGame = game
                            }) {
                                Text(game.name)
                            }                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(selectedGame.name)
                                .font(.title)
                            Image(systemName: "chevron.down")
                                .font(.subheadline)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // TODO: accion de notificaciones en futuro
                    }) {
                        Image(systemName: "bell")
                            .font(.title2)
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
