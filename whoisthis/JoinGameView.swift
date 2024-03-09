//
//  JoinGameView.swift
//  whoisthis
//
//  Created by Kaan Şenol on 9.03.2024.
//

import SwiftUI

struct JoinGameView: View {
    @ObservedObject  var model: GameViewModel
    @State private var game_id: String = ""
    @State private var name: String = ""
    var body: some View {
        VStack {
            TextField("Enter Game ID", text: $game_id)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(game_id.publisher.collect()) {
                    self.game_id = String($0.prefix(6))
                }
            TextField("Enter Name", text: $name)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(name.publisher.collect()) {
                    self.name = String($0.prefix(6))
                }

            Button("Join Game") {
                model.GameID = Int(self.game_id) ?? 0
                model.player_name = name
                model.joinGame()
            }
            .buttonStyle(MainButtonStyle())
        }
        .padding()
    }
}

struct JoinGameView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGameView(model: GameViewModel())
    }
}

