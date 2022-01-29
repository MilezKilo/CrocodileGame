//
//  SettingsVM.swift
//  Crocodile!
//
//  Created by Майлс on 25.01.2022.
//

import Foundation

class SettingsVM: ObservableObject {
    
    @Published var scoreValue: Int = 5 {
        didSet {
            savescore()
        }
    }
    @Published var teamsCount: Int = 2 {
        didSet {
            saveTeamsCount()
        }
    }
    @Published var currentBackground: String = "greenBackgroundThree" {
        didSet {
            saveBackground()
        }
    }
    let scoreKey = "score_key"
    let teamsKey = "teams_key"
    let backgroundKey = "background_key"
    
    init() { getScore(); getTeamsCount(); getBackground() }
    
    //SCORE METHODS
    func getScore() {
        guard
            let score = UserDefaults.standard.data(forKey: scoreKey),
            let savedScore = try? JSONDecoder().decode(Int.self, from: score) else {
                return
            }
        self.scoreValue = savedScore
    }
    func savescore() {
        if let encodedScore = try? JSONEncoder().encode(scoreValue) {
            UserDefaults.standard.set(encodedScore, forKey: scoreKey)
        }
    }
    
    //TEAMS COUNT METHODS
    func getTeamsCount() {
        guard
            let teams = UserDefaults.standard.data(forKey: teamsKey),
            let savedCount = try? JSONDecoder().decode(Int.self, from: teams) else {
                return
            }
        self.teamsCount = savedCount
    }
    func saveTeamsCount() {
        if let encodedCount = try? JSONEncoder().encode(teamsCount) {
            UserDefaults.standard.set(encodedCount, forKey: teamsKey)
        }
    }
    
    //BACKGROUND METHODS
    func getBackground() {
        guard
            let background = UserDefaults.standard.data(forKey: backgroundKey),
            let savedBackground = try? JSONDecoder().decode(String.self, from: background) else {
                return
            }
        self.currentBackground = savedBackground
    }
    func saveBackground() {
        if let encodedBackground = try? JSONEncoder().encode(currentBackground) {
            UserDefaults.standard.set(encodedBackground, forKey: backgroundKey)
        }
    }
}
