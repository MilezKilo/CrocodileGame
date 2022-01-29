//
//  SettingsView.swift
//  Crocodile!
//
//  Created by Майлс on 24.01.2022.
//

import SwiftUI

struct SettingsView: View {
    
    //BINDING STATE TO CHANGE CURRENT VIEW
    @Binding var viewStates: Int
        
    @EnvironmentObject private var settingsVM: SettingsVM
    @EnvironmentObject private var teamsVM: TeamVM
    
    let backgrounds = ["greenBackground", "greenBackgroundTwo", "greenBackgroundThree"]
    
    var body: some View {
        VStack(spacing: 25) {
            header.padding(.bottom)
            if teamsVM.teamsRow.isEmpty {
                scoreStepper
                teamsCountStepper
            } else {
                deleteTeamsView
            }
            
            backgroundPicker
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
    }
}

//MARK: - EXTENSION
extension SettingsView {
    //BUTTONS
    private var backButton: some View {
        HeaderButtonTemplate(image: "chevron.left", width: 10, height: 10, color: Color.colorsTheme.buttonForegroundColor)
            .onTapGesture { viewStates = 0 }
    }
    
    //VIEWS
    private var header: some View {
        HStack {
            backButton
            Spacer()
            Text("Настройки")
                .font(.title)
                .padding(.trailing, 40)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
    }
    private var scoreStepper: some View {
        HStack {
            Text("Счет до победы: \(settingsVM.scoreValue)")
            Stepper("", value: $settingsVM.scoreValue, in: 5...20)
        }
        .foregroundColor(.black)
        .padding(10)
        .background(Color.white.cornerRadius(10))
        .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
    private var teamsCountStepper: some View {
        HStack {
            Text("Кол-во команд: \(settingsVM.teamsCount)")
            Stepper("", value: $settingsVM.teamsCount, in: 2...8)
        }
        .foregroundColor(.black)
        .padding(10)
        .background(Color.white.cornerRadius(10))
        .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
    private var backgroundPicker: some View {
        VStack(alignment: .leading) {
            Text("Задний фон")
                .foregroundColor(.green)
                .font(.title)
            Picker(selection: $settingsVM.currentBackground, label: Text("")) {
                ForEach(backgrounds, id: \.self) { background in
                    if background == "greenBackground" {
                        Text("Вариант 1")
                    } else if background == "greenBackgroundTwo" {
                        Text("Вариант 2")
                    } else {
                        Text("Вариант 3")
                    }
                }
            }
            .tint(Color.black)
            .pickerStyle(SegmentedPickerStyle())
        }
        .foregroundColor(.black)
        .padding(10)
        .background(Color.white.cornerRadius(10))
        .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
    private var deleteTeamsView: some View {
        Text("Удалите вначале все команды, для изменения настроек игры!")
            .foregroundColor(.black)
            .font(.headline)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
            .background(Color.white.cornerRadius(10))
            .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
}

//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewStates: .constant(5))
            .environmentObject(SettingsVM())
            .environmentObject(TeamVM())
    }
}
