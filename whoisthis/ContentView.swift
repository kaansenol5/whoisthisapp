//
//  ContentView.swift
//  whoisthis
//
//  Created by Kaan Şenol on 7.03.2024.
//

import Foundation
import SwiftUI

// This view represents the initial screen of your app
struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to the Game")
                .font(.largeTitle)

            Button("Create Game") {
                viewModel.sendEvent(event: "create_game", withData: ["dat":"dat"])
            }
            .buttonStyle(MainButtonStyle())

            Button("Join Game") {
                print("Join Game tapped")
            }
            .buttonStyle(MainButtonStyle())
        }
        .padding()
    }
}

// Preview provider for Xcode previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
