//
//  WordsVM.swift
//  Crocodile!
//
//  Created by Майлс on 14.01.2022.
//

import Foundation

class WordsVM: ObservableObject {
    
    //GAME MODE PROPERTIES
    @Published var currentGameMode: [String] = [] {
        didSet {
            saveGameMode()
        }
    }
    @Published var gameModesImages: [String] = [
        "face.smiling.fill", "bolt.fill", "flame.fill", "pawprint.fill", "pencil", "hand.raised.fill"
    ]
    let key = "some_key"
    
    //TEXT DESCRIPTION PROPERTIES
    @Published var textDescription: String = "" {
        didSet {
            saveTextDescription()
        }
    }
    let textKey = "text_key"
    
    //QUESTION PROPERTIES
    @Published var index: Int = 0
    
    static let easyWords = EasyDifficulty().easy
    static let mediumWords = MediumDifficulty().medium
    static let hardWords = HardDifficulty().hard
    static let animalsWords = AnimalsWords().animals
    static let paintingWords = WordsForPainting().painting
    static let showWords = WordsForGestures().gestures
    
    init() {
        getGameMode()
        getTextDescription()
    }
    
    //GAME MODE METHODS
    func getGameMode() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let savedData = try? JSONDecoder().decode([String].self, from: data)
        else { return }
        currentGameMode = savedData
    }
    func saveGameMode() {
    if let encodedData = try? JSONEncoder().encode(currentGameMode) {
        UserDefaults.standard.set(encodedData, forKey: key)
    }
}
    func changeGameMode(mode: [String]) {
        currentGameMode = mode
    }
    
    //QUESTIONS METHODS
    func changeQuestion() {
        index += 1
        if index == currentGameMode.count {
            index = 0
        }
    }
    func refreshQuestions() {
    currentGameMode.shuffle()
}
    
    //TEXT DESCRIPTION METHODS
    func getTextDescription() {
        guard
            let data = UserDefaults.standard.data(forKey: textKey),
            let savedData = try? JSONDecoder().decode(String.self, from: data)
        else { return }
        textDescription = savedData
    }
    func saveTextDescription() {
        if let encodedData = try? JSONEncoder().encode(textDescription) {
            UserDefaults.standard.set(encodedData, forKey: textKey)
        }
    }
    func changeDescription(text: String) {
        textDescription = text
    }
    
}
