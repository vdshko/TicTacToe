//
//  AppState.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import Combine

final class AppState: ObservableObject {
    
    @Published var gameBoard: [Move?] = Array(repeating: nil, count: 9)
    @Published var isProfileShown: Bool = false
    
    var gameType: GameType = GameType.singlePlayer
}
