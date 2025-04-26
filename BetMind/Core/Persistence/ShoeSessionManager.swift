//
//  ShoeSessionManager.swift
//  BetMind
//
//  Created by Carlos Cardona on 26/04/25.
//

import Foundation

final class ShoeSessionManager {
    static let shared = ShoeSessionManager()
    
    private let sessionKey = "shoe_sessions"
    
    private init() {}
    
    func saveSession(_ session: ShoeSession) {
        var sessions = loadSessions()
        sessions.append(session)
        
        if let encoded = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(encoded, forKey: sessionKey)
        }
    }
    
    func loadSessions() -> [ShoeSession] {
        guard let data = UserDefaults.standard.data(forKey: sessionKey),
              let sessions = try? JSONDecoder().decode([ShoeSession].self, from: data) else {
            return []
              }
        return sessions
    }
    
    func clearAllSessions() {
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
}
