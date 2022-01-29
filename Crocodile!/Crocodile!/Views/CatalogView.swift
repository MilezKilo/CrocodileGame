//
//  CatalogView.swift
//  Crocodile!
//
//  Created by Майлс on 11.01.2022.
//

import SwiftUI

struct CatalogView: View {
    
    //BINDING STATE TO CHANGE CURRENT VIEW
    @Binding var viewStates: Int
    //WORDS VIEW MODEL
    @EnvironmentObject var wordsVM: WordsVM
    
    var body: some View {
        VStack {
            header
            catalog
        }
    }
}

//MARK: - EXTENSION
extension CatalogView {
    //BUTTONS
    private var backButton: some View {
        HeaderButtonTemplate(image: "chevron.left", width: 10, height: 10, color:  Color.colorsTheme.buttonForegroundColor)
            .onTapGesture { viewStates = 0 }
    }
    private var header: some View {
        HStack {
            backButton
            Spacer()
            Text("РЕЖИМЫ ИГРЫ")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer(minLength: 65)
        }.padding()
    }
    
    //VIEWS
    private var catalog: some View {
        VStack {
            Text("КОЛИЧЕСТВО СЛОВ В ПАКЕ - \(wordsVM.currentGameMode.count)")
                .padding()
                .background(Color.colorsTheme.buttonColor.cornerRadius(5))
                .shadow(color: Color.black.opacity(0.5), radius: 10)
                .foregroundColor(.white)
            ScrollView {
                easyGameMode
                mediumGameMode
                hardGameMode
                animalsGameMode
                paintGameMode
                gestureGameMode
            }
            .padding()
        }
    }
    
    //BUTTONS(TEMPORARY)
    private var easyGameMode: some View {
        ButtonTemplate(title: "ЛЕГКО", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.easyWords
                wordsVM.changeDescription(text: "Объясните с помощью слов")
            }
    }
    private var mediumGameMode: some View {
        ButtonTemplate(title: "СРЕДНЕ", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.mediumWords
                wordsVM.changeDescription(text: "Объясните с помощью слов")
            }
    }
    private var hardGameMode: some View {
        ButtonTemplate(title: "СЛОЖНО", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.hardWords
                wordsVM.changeDescription(text: "Объясните с помощью слов")
            }
    }
    private var animalsGameMode: some View {
        ButtonTemplate(title: "ЖИВОТНЫЕ", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.animalsWords
                wordsVM.changeDescription(text: "Объясните с помощью слов")
            }
    }
    private var paintGameMode: some View {
        ButtonTemplate(title: "РИСОВАНИЕ", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.paintingWords
                wordsVM.changeDescription(text: "Нарисуйте")
            }
    }
    private var gestureGameMode: some View {
        ButtonTemplate(title: "ЖЕСТЫ", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .onTapGesture {
                wordsVM.currentGameMode = WordsVM.showWords
                wordsVM.changeDescription(text: "Покажите жестами")
            }
    }
}

//MARK: - PREVIEW
struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(viewStates: .constant(2))
            .environmentObject(WordsVM())
            .navigationBarHidden(true)
    }
}
