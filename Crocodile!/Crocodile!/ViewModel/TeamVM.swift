//
//  PlayersVM.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import Foundation

class TeamVM: ObservableObject {
    
    @Published var teamsRow: [Team] = [] {
        didSet {
            saveTeams()
        }
    }
    let key = "teams_list"
    var teamIndex: Int = 1
    
    init() { getTeams() }
    
    //JSON MANUPULATION METHODS
    func getTeams() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let savedItems = try? JSONDecoder().decode([Team].self, from: data)
        else { return }
        
        self.teamsRow = savedItems
    }
    func saveTeams() {
        if let encodedData = try? JSONEncoder().encode(teamsRow) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }

    //TEAM MANIPULATIONS METHODS
    func addTeam(name: String, image: String) {
        let newteam = Team(image: image, name: name)
        teamsRow.append(newteam)
    }
    func deleteTeam(at index: Int) {
        teamsRow.remove(at: index)
    }
    func changeTeam() {
        teamIndex += 1
        if teamIndex == teamsRow.count {
            teamIndex = 0
        }
    }
    
    //TEAM SCORE METHODS
    func increaseScore() {
        teamsRow[teamIndex].score += 1
    }
    func decreaseScore() {
        teamsRow[teamIndex].score -= 1
    }
}
