//
//  Players.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import Foundation

struct Team: Identifiable, Codable {
    var id = UUID().uuidString
    let image: String
    let name: String
    var score: Int = 0
}
