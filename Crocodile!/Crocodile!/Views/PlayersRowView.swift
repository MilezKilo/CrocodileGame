//
//  PlayersRowView.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import SwiftUI

struct PlayersRowView: View {
    
    //VIEW MODEL'S
    @EnvironmentObject private var playersVM: TeamVM
    @EnvironmentObject private var wordsVM: WordsVM
    @EnvironmentObject private var settingsVM: SettingsVM
    
    //BINDING STATE TO CHANGE CURRENT VIEW
    @Binding var viewStates: Int
    //STATE THAT OPEN ADD TEAM VIEW
    @State private var showAddView: Bool = false
    //STATE THAT OPEN ALERT
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                header
                teamsRow
                if !showAddView {
                    addTeamsButton
                        .opacity(settingsVM.teamsCount == playersVM.teamsRow.count ? 0 : 1)
                        .disabled(settingsVM.teamsCount == playersVM.teamsRow.count ? true : false)
                    startGameButton
                } else {
                    AddTeamView(showAddTeamView: $showAddView)
                        .offset(y: 35)
                        .transition(AnyTransition.opacity.animation(.easeIn))
                }
            }
        }
    }
}

//MARK: - EXTENSION
//VIEWS
extension PlayersRowView {
    
    //VIEWS
    private var teamsRow: some View {
        List {
            ForEach(playersVM.teamsRow) { player in
                HStack {
                    Image(player.image)
                        .resizable()
                        .frame(width: 65, height: 65)
                    Text(player.name)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.colorsTheme.buttonForegroundColor)
                        .padding(.leading, 35)
                        .addBorder(Color.colorsTheme.buttonForegroundColor, width: 1, cornerRadius: 35)
                    HeaderButtonTemplate(image: "xmark", width: 20, height: 20, color:  Color.colorsTheme.altButtonForegroundColor)
                        .onTapGesture {
                            playersVM.deleteTeam(at: playersVM.teamsRow.firstIndex(where: {$0.id == player.id})!)
                        }
                }
            }
            .padding(.horizontal)
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
    private var header: some View {
        HStack {
            backButton
            Spacer()
            Text("КТО ИГРАЕТ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.colorsTheme.buttonForegroundColor)
            Spacer(minLength: 85)
        }.padding(.horizontal)
    }
    
    //BUTTONS
    private var backButton: some View {
        HeaderButtonTemplate(image: "chevron.left", width: 10, height: 10, color:  Color.colorsTheme.buttonForegroundColor)
            .onTapGesture {
                viewStates = 0
            }
    }
    private var startGameButton: some View {
        ButtonTemplate(title: "ИГРОКИ ГОТОВЫ", width: UIScreen.main.bounds.width * 0.7, height: 65, font: .title3, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                if playersVM.teamsRow.count <= 1 {
                    showAlert.toggle()
                } else {
                    viewStates = 4
                    wordsVM.refreshQuestions()
                }
            }
            .padding(.horizontal)
            .opacity(playersVM.teamsRow.count <= 1 ? 0.7 : 1)
            .alert(isPresented: $showAlert) { myAlert() }
    }
    private var addTeamsButton: some View {
        ButtonTemplate(title: "ДОБАВИТЬ КОМАНДУ", width: UIScreen.main.bounds.width * 0.7, height: 65, font: .title3, color: Color.colorsTheme.alternativeButtonColor)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showAddView = true
                }
            }
    }
    
    //METHODS
    private func myAlert() -> Alert {
        let alert = Alert(title: Text("Для начала игры добавьте две, или более команды!"), message: nil, dismissButton: .default(Text("Хорошо")))
        return alert
    }
}

//MARK: - PREVIEW
struct PlayersRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersRowView(viewStates: .constant(1))
            .environmentObject(TeamVM())
            .environmentObject(WordsVM())
            .environmentObject(SettingsVM())
    }
}
