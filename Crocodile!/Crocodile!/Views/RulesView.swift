//
//  RulesView.swift
//  Crocodile!
//
//  Created by Майлс on 11.01.2022.
//

import SwiftUI

struct RulesView: View {
    
    @Binding var viewStates: Int
    
    var body: some View {
            VStack {
                header
                rules
                Spacer()
            }
        
    }
}

extension RulesView {
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
            Text("Правила")
                .font(.title)
                .padding(.trailing, 45)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
    }
    private var rules: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
        .frame(
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.65)
        .overlay(textOverlay.padding(), alignment: .topLeading)
        .shadow(color: Color.black.opacity(0.3), radius: 10)
    }
    
    //OVERLAYS
    private var textOverlay: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Коротко об игре".uppercased())
                .foregroundColor(.green)
                .font(.title)
            Text("Игру \"Крокодил\" в наше стране знают почти все. Даже те, кто ее не знает, играют в нее с иностранцами во время турпоездок. Правила очень просты: нужно объяснять слова, так чтобы вас поняли.\n\nВ игре 3 типа карточек, некоторые слова надо показывать жестами, некоторые рисовать. И последник тип - просто объяснять словами. На все дается 1 минута!\n\nНеобходимо разделится на команды, один человек объясняет, другие отгадывают, выступая командами, вы разовьете командный дух и научитесь понимать товарищей с одного движения!\n\nУдачи и хорошей вам игры!")
                .foregroundColor(.black)
        }
    }
}

//MARK: - PREVIEW
struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView(viewStates: .constant(3))
    }
}
