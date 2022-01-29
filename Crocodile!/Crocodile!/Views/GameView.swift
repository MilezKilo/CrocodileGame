//
//  GameView.swift
//  Crocodile!
//
//  Created by Майлс on 11.01.2022.
//

import SwiftUI

struct GameView: View {
    
    //VIEW MODEL'S
    @EnvironmentObject private var teamsVM: TeamVM
    @EnvironmentObject private var wordsVM: WordsVM
    @EnvironmentObject private var settingsVM: SettingsVM
    
    //BINDING STATE TO CHANGE CURRENT VIEW
    @Binding var viewStates: Int
    
    //TIMER PROPERTIES
    @State private var timerCount: Int = 60
    @State private var startTimer: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //ALERTS PROPERTIES
    @State private var alertType: MyAlerts? = nil
    @State private var showAlert: Bool = false
    enum MyAlerts {
        case isTimerEnd, success, failure, winning
    }
    
    //COLORS
    let color = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    var body: some View {
        VStack(spacing: 15) {
            header
                .padding(.vertical)
            questionRectange
            Spacer()
            if startTimer {
                violationButton
                .transition(AnyTransition.opacity.animation(.spring()))
            }
            Spacer()
        }
    }
}

//MARK: - EXTENSION
extension GameView {
    //BUTTONS
    private var backButton: some View {
        HeaderButtonTemplate(image: "chevron.left", width: 10, height: 10, color:  Color.colorsTheme.buttonForegroundColor)
            .onTapGesture {
                wordsVM.refreshQuestions()
                viewStates = 1
            }
    }
    private var violationButton: some View {
        ButtonTemplate(
            title: "НАРУШЕНИЕ ПРАВИЛ",
            width: UIScreen.main.bounds.width,
            height: 65,
            font: .title2,
            color: Color(color))
            .onTapGesture {
                teamsVM.decreaseScore()
                alertType = .failure
                showAlert = true
            }
            .padding(.horizontal)
    }
    
    //VIEWS
    private var header: some View {
        HStack {
            backButton
            teamView
                .padding()
                .background(Color(backgroundColor)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.3), radius: 10))
                .padding(.trailing, 50)
        }
    }
    private var teamView: some View {
        HStack {
            Image(teamsVM.teamsRow[teamsVM.teamIndex].image)
                .resizable()
                .frame(width: 65, height: 65)
            Text(teamsVM.teamsRow[teamsVM.teamIndex].name)
                .frame(width: 120, alignment: .trailing)
                .font(.title2)
            Capsule()
                .frame(width: 2, height: 60)
            VStack {
                Text("\(teamsVM.teamsRow[teamsVM.teamIndex].score)")
                    .font(.title2)
                Text("Очки")
                    .font(.headline)
            }
        }
        .foregroundColor(.black)
    }
    
    //MAIN RECTANGLE WITH QUESTION AND BUTTONS
    private var questionRectange: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(
                width: UIScreen.main.bounds.width * 0.8,
                height: UIScreen.main.bounds.height * 0.5)
            .padding(.horizontal)
            .foregroundColor(Color(backgroundColor))
            .shadow(color: Color.black.opacity(0.7), radius: 10)
            .overlay(overlayForView)
    }
    
    //OVERLAYS FOR RECTANGLE
    private var questionRectangeOverlay: some View {
        VStack {
            Spacer(minLength: 75)
            if startTimer {
                questionsView
                    .transition(AnyTransition.opacity.animation(.spring()))
                acceptViewCircleButton
                    .transition(AnyTransition.opacity.animation(.spring()))
            } else {
                startView
                    .transition(AnyTransition.opacity.animation(.spring()))
                startViewCircleButton
                    .transition(AnyTransition.opacity.animation(.spring()))
                    .padding(.bottom, 25)
            }
        }
    }
    private var noDataInQuestionArrayOverlay: some View {
        VStack {
            Text("Вы не выбрали режим игры")
                .font(.headline)
                .foregroundColor(.black)
            ButtonTemplate(
                title: "Вернуться назад...",
                width: UIScreen.main.bounds.width * 0.6,
                height: 65, font: .title2,
                color: Color.colorsTheme.buttonColor)
                .onTapGesture {
                viewStates = 0
            }
        }
    }
    
    //MAIN OVERLAY
    private var overlayForView: some View {
        VStack {
            if wordsVM.currentGameMode.isEmpty {
                noDataInQuestionArrayOverlay
            } else {
                questionRectangeOverlay
            }
        }
    }
    
    //OVERLAYS FOR START/ACCEPT BUTTONS
    private var overlayForTimerView: some View {
        Image(systemName: "play.fill")
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .onReceive(timer) { _ in
                    if startTimer {
                        if timerCount >= 1 {
                            timerCount -= 1
                        }
                    }
                }
    }
    private var overlayForAcceptView: some View {
        Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
    }
    
    //OTHER OVERLAYS
    private var questionsView: some View {
        Text(wordsVM.currentGameMode[wordsVM.index].capitalized)
            .font(.title)
            .fontWeight(.bold)
            .italic()
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 100)
    }
    private var startView : some View {
        VStack {
            Image("crocodile_main")
                .resizable()
                .frame(width: 200, height: 200)
            
            Text(wordsVM.textDescription)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
    
    //BOTTOM CIRCLES
    private var startViewCircleButton: some View {
        VStack {
            Spacer()
            Circle()
                .frame(width: 75, height: 75)
                .foregroundColor(.green)
                .shadow(color: Color.black.opacity(0.4), radius: 10)
                .padding()
                .overlay(overlayForTimerView)
                .onTapGesture {
                    withAnimation(.spring()) {
                        guard !wordsVM.currentGameMode.isEmpty else { return }
                        startTimer = true
                    }
                }
                .padding(.bottom, 28)
        }
    }
    private var acceptViewCircleButton: some View {
        VStack {
            Spacer()
            Circle()
                .frame(width: 75, height: 75)
                .foregroundColor(.green)
                .shadow(color: Color.black.opacity(0.3), radius: 10)
                .overlay(overlayForAcceptView)
                .onTapGesture {
                    if teamsVM.teamsRow[teamsVM.teamIndex].score == settingsVM.scoreValue - 1 {
                        teamsVM.increaseScore()
                        alertType = .winning
                        showAlert = true
                    } else {
                        teamsVM.increaseScore()
                        alertType = .success
                        showAlert = true
                    }
                }
                
            Text("\(timerCount) секунд")
                .font(.system(size: 17.5, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                    .onReceive(timer) { _ in
                        if startTimer {
                            if timerCount >= 1 {
                                timerCount -= 1
                            } else {
                                alertType = .isTimerEnd
                                showAlert = true
                            }
                        }
                    }
        }
        .alert(isPresented: $showAlert) { enumAlerts() }
        .padding(.bottom)
    }
    
    //METHODS
    func enumAlerts() -> Alert {
        switch alertType {
        case .isTimerEnd:
            let alert = Alert(
                title: Text("Время вышло, увы..."),
                message: Text("Следующая команда:"),
                dismissButton: .default(Text("Хорошо")) {
                    teamsVM.changeTeam()
                    startTimer = false
                    wordsVM.changeQuestion()
                    timerCount = 60
                })
            return alert
        case .success:
            let alert = Alert(
                title: Text("Верный ответ!"),
                message: Text("Счет команды: \(teamsVM.teamsRow[teamsVM.teamIndex].name) увеличен!"),
                dismissButton: .default(Text("Отлично!")) {
                    teamsVM.changeTeam()
                    wordsVM.changeQuestion()
                    timerCount = 60
                    startTimer = false
                })
            return alert
        case .failure:
            let alert = Alert(
                title: Text("Вы сжульничали!"),
                message: Text("Минус балл команде: \(teamsVM.teamsRow[teamsVM.teamIndex].name)"),
                dismissButton: .default(Text("Понятно...")) {
                    teamsVM.changeTeam()
                    wordsVM.changeQuestion()
                    timerCount = 60
                    startTimer = false
                })
            return alert
        case .winning:
            let alert = Alert(
                title: Text("Победа!"),
                message: Text("Поздравлем команду \(teamsVM.teamsRow[teamsVM.teamIndex].name)!"),
                dismissButton: .default(Text("Отлично")) {
                    timerCount = 60
                    startTimer = false
                    viewStates = 1
                    wordsVM.refreshQuestions()
                })
            return alert
        case .none:
            return Alert(title: Text("ERROR"))
        }
    }
}

//MARK: - PREVIEW
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewStates: .constant(4))
            .environmentObject(WordsVM())
            .environmentObject(TeamVM())
    }
}
