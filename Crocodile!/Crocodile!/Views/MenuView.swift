//
//  MenuView.swift
//  Crocodile!
//
//  Created by Майлс on 10.01.2022.
//

import SwiftUI

struct MenuView: View {
        
    //BINDING STATE TO CHANGE CURRENT VIEW
    @Binding var viewStates: Int
    
    var body: some View {
            
            VStack {
                Image("crocodile_main")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                Text("КРОКОДИЛ!")
                    .font(.system(size: 60))
                    .foregroundColor(Color.colorsTheme.buttonForegroundColor)
                runGameButton
                catalogButton
                rulesAndMyProjectsButton
                SettingsButton
            }
            .padding(.bottom)
    }
}

//MARK: - EXTENSION
extension MenuView {
    //BUTTONS
    private var runGameButton: some View {
        ButtonTemplate(title: "НАЧАТЬ ИГРУ", width: UIScreen.main.bounds.width * 0.7, height: 65, font: .title3, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                viewStates = 1
            }
    }
    private var catalogButton: some View {
        ButtonTemplate(title: "КАТАЛОГ", width: UIScreen.main.bounds.width * 0.7, height: 65, font: .title3, color: Color.colorsTheme.buttonColor)
            .onTapGesture { viewStates = 2 }
    }
    private var rulesAndMyProjectsButton: some View {
        HStack(spacing: 0) {
            ButtonTemplate(title: "ПРАВИЛА ИГРЫ", width: UIScreen.main.bounds.width * 0.34, height: 65, font: .headline, color: Color.colorsTheme.buttonColor)
                .onTapGesture {
                    viewStates = 3
                }
            Link(destination: URL(string: "https://github.com/MilezKilo?tab=repositories")!) {
                ButtonTemplate(title: "МОИ ПРОЕКТЫ", width: UIScreen.main.bounds.width * 0.34, height: 65, font: .headline, color: Color.colorsTheme.buttonColor)
            }
                
        }
        .multilineTextAlignment(.center)
    }
    private var SettingsButton: some View {
        ButtonTemplate(title: "НАСТРОЙКИ", width: UIScreen.main.bounds.width * 0.7, height: 45, font: .title3, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                viewStates = 5
            }
            .padding(.top)
    }
}

//MARK: - PREVIEW
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewStates: .constant(0))
    }
}
