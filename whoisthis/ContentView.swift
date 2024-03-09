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
    @State var in_game = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to the Game")
                    .font(.largeTitle)
                Text(String(viewModel.GameID))
                Button("Create Game") {
                    viewModel.sendEvent(event: "create_game")
                }.buttonStyle(MainButtonStyle())
                

                
                NavigationLink(destination: JoinGameView(model: viewModel)) {
                    Text("Join Game")
                }.buttonStyle(MainButtonStyle() )
                }
            }
        }
    }

// Preview provider for Xcode previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
