//
//  Crocodile_App.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import SwiftUI

@main
struct Crocodile_App: App {
    
    @StateObject var playersVM: TeamVM = TeamVM()
    @StateObject var wordsVM: WordsVM = WordsVM()
    @StateObject var settingsVM: SettingsVM = SettingsVM()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(playersVM)
                    .environmentObject(wordsVM)
                    .environmentObject(settingsVM)
                    .navigationBarHidden(true)
            }
        }
    }
}
