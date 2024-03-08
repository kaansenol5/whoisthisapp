//
//  GameData.swift
//  whoisthis
//
//  Created by Kaan Şenol on 8.03.2024.
//

import Foundation


struct Player: Decodable {
    let name: String
    let points: Int
    let answered: Bool
    let answer: Int
}


struct Game: Decodable {
    let id: Int
    let players: [Player]
}
