//
//  SportsFollowSetupView.swift
//  BetMind
//
//  Created by Carlos Cardona on 28/04/25.
//

import SwiftUI

struct SportsFollowSetupView: View {
    
    let onCompleted: () -> Void
    
    @State private var selectedFavorites: Set<String> = []
    
    private let availableFavorites = [
        "Real Madrid", "Barcelona", "Manchester City", "Lakers", "Warriors", "Yankees", "Red Sox"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(availableFavorites, id: \.self) { favorite in
                            favoriteRow(favorite)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                
                Button(action: saveFavorites) {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedFavorites.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(selectedFavorites.isEmpty)
                
                Spacer()
            }
            .navigationTitle("Follow your teams")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func favoriteRow(_ favorite: String) -> some View {
        Button(action:{
            if selectedFavorites.contains(favorite) {
                selectedFavorites.remove(favorite)
            } else {
                selectedFavorites.insert(favorite)
            }
        }) {
            HStack {
                Text(favorite)
                    .font(.body)
                Spacer()
                if selectedFavorites.contains(favorite) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
        }
    }
    
    private func saveFavorites() {
        let favoritesArray = Array(selectedFavorites)
        UserDefaults.standard.set(favoritesArray, forKey: "userFavorites")
        UserDefaults.standard.set(true, forKey: "didCompleteFollowSetup")
        onCompleted()
    }
}

//#Preview {
//    SportsFollowSetupView()
//}
