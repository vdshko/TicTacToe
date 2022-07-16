//
//  GameProgressService.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 16.07.2022.
//

import Foundation

protocol GameProgressService {
    
    func makeMove(at index: Int)
}

final class GameProgressServiceImpl: GameProgressService {
    
    private var player: Move.Player {
        guard isEvenMove else {
            return .player1
        }
        
        switch appState.profile.gameType {
        case .singlePlayer: return .computer
        case .multiPlayer: return .player2
        }
    }
    
    private var gameFigure: Move.GameFigure {
        switch player {
        case .player1: return Move.GameFigure.xmark
        case .player2, .computer: return Move.GameFigure.circle
        }
    }
    
    private var winPatterns: Set<Set<Int>> = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ]
    private var isEvenMove: Bool = false
    private var lastMove: Move?
    
    private let appState: AppState
    private let aiEngine: AIEngine
    
    init(appState: AppState, aiEngine: AIEngine) {
        self.appState = appState
        self.aiEngine = aiEngine
        self.aiEngine.set(winPatterns: winPatterns)
    }
    
    func makeMove(at index: Int) {
        guard appState.gameBoard[index] == nil else {
            return
        }
        
        lastMove = Move(boardIndex: index, player: player, gameFigure: gameFigure)
        isEvenMove.toggle()
        appState.gameBoard[index] = lastMove
        
        if isEvenMove,
           case GameType.singlePlayer = appState.profile.gameType {
            fireAIMove()
        }
    }
    
    private func fireAIMove() {
        let moveIndex: Int = aiEngine.produceMoveIndex(for: appState.gameBoard)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.aiThrottle) {
            self.makeMove(at: moveIndex)
        }
    }
}

private extension GameProgressServiceImpl {
    
    enum Constants {
        
        static let aiThrottle: Double = 0.5
    }
}
