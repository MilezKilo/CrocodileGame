//
//  HomeView.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import SwiftUI

struct HomeView: View {
    
    //PLAYERS VIEW MODEL
    @EnvironmentObject private var playersVM: TeamVM
    @EnvironmentObject private var settingsVM: SettingsVM
    //CURRENT VIEW
    @State private var viewStates: Int = 0
    
    var body: some View {
        ZStack {
            Image(settingsVM.currentBackground)
                .resizable()
                .brightness(-0.1)
                .ignoresSafeArea()
            switch viewStates {
            case 0: MenuView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            case 1: PlayersRowView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            case 2: CatalogView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            case 3: RulesView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            case 4: GameView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            case 5: SettingsView(viewStates: $viewStates)
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
            default: Text("DEFAULT")
            }
        }
    }
}


//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .environmentObject(TeamVM())
                .environmentObject(WordsVM())
                .environmentObject(SettingsVM())
        }
    }
}
