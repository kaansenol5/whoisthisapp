//
//  connection.swift
//  whoisthis
//
//  Created by Kaan Şenol on 8.03.2024.
//
import Foundation
import Combine
import SocketIO

class GameViewModel: ObservableObject {
    private var socketManager: SocketManager?
    private var socket: SocketIOClient?
    @Published var latestQuestion: String = ""// Assume Photo is a struct that represents your photo
    @Published var questionOptions: [String] = [""]
    @Published var playerData: [Player] = []
    @Published var GameID: Int = 0
    @Published var connected: Bool = false
    init() {
        socketManager = SocketManager(socketURL: URL(string: "http://localhost:6000")!, config: [.log(true), .compress])
        socket = socketManager?.defaultSocket
        
        socket?.on(clientEvent: .connect) {data, ack in
            print("Socket connected")
        }
        
        socket?.on("game_created") { [weak self] data, ack in
            guard let self = self,
                  let gameInfo = data.first as? [String: Any], // Make sure this matches the structure you're sending from the server
                  let gameId = gameInfo["game_id"] as? String else { return }
            
            DispatchQueue.main.async {
                // Now you have the gameId, do whatever you need with it in your app
                print("Received game ID: \(gameId)")
                self.GameID = Int(gameId)!
                // For example, you might update some published property with this game ID
            }
        }
        
        socket?.on("game_created") { [weak self] data, ack in
            guard let self = self,
                  let gameInfo = data.first as? [String: Any], // Make sure this matches the structure you're sending from the server
                  let gameId = gameInfo["game_id"] as? String else { return }
            
            DispatchQueue.main.async {
                // Now you have the gameId, do whatever you need with it in your app
                print("Received game ID: \(gameId)")
                self.GameID = Int(gameId)!
                // For example, you might update some published property with this game ID
            }
        }
        
        socket?.on("question") { [weak self] data, ack in
            guard let self = self,
                  let gameInfo = data.first as? [String: Any], // Make sure this matches the structure you're sending from the server
                  let question = gameInfo["question"] as? String else { return }
            
            DispatchQueue.main.async {
                // Now you have the gameId, do whatever you need with it in your app
                self.latestQuestion = question
                // For example, you might update some published property with this game ID
            }
        }

        socket?.on("game_created") { [weak self] data, ack in
            guard let self = self,
                  let gameInfo = data.first as? [String: Any], // Make sure this matches the structure you're sending from the server
                  let gameId = gameInfo["game_id"] as? String else { return }
            
            DispatchQueue.main.async {
                // Now you have the gameId, do whatever you need with it in your app
                print("Received game ID: \(gameId)")
                self.GameID = Int(gameId)!
                // For example, you might update some published property with this game ID
            }
        }
        
        socket?.on("question_over") { [weak self] data, ack in
            guard let self = self,
                  let gameInfo = data.first as? [String: Any], // Make sure this matches the structure you're sending from the server
                  let playerStatesJSON = gameInfo["playerstates"] as? [String: Any], // Access the playerstates part of the data
                  let correct_answer = gameInfo["correct_answer"] as? String else { return }
                
            do {
                let playerStatesData = try JSONSerialization.data(withJSONObject: playerStatesJSON)
                let playerStates = try JSONDecoder().decode([Player].self, from: playerStatesData)
                
                DispatchQueue.main.async {
                    // Now you can use both playerStates and gameId in your UI updates
                    self.playerData = playerStates
                    // For example, update some published properties with the game ID and player state
                }
            } catch {
                print("Error decoding player states: \(error)")
            }
            
        }
        
        socket?.connect()
    }
    func sendEvent(event: String, withData data: [String: Any]) {
        socket?.emit(event, data)
    }
    
    deinit {
        socket?.disconnect()
    }
}
