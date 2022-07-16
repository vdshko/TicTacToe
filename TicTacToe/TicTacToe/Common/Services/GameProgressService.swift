//
//  GameProgressService.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 16.07.2022.
//

import Foundation
import Combine

protocol GameProgressService {
    
    var winPublisher: PassthroughSubject<Move, Never> { get }
    var drawPublisher: PassthroughSubject<Void, Never> { get }
    var isAIСonsideringMovePublisher: PassthroughSubject<Bool, Never> { get }
    
    func makeMove(at index: Int)
    func restartGame()
}

final class GameProgressServiceImpl: GameProgressService {
    
    let winPublisher: PassthroughSubject<Move, Never> = PassthroughSubject()
    let drawPublisher: PassthroughSubject<Void, Never> = PassthroughSubject()
    let isAIСonsideringMovePublisher: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
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
    
    private var isWinCondition: Bool {
        guard let lastMove = lastMove else {
            return false
        }
        
        let playerMovesIndexes: Set<Int> = Set(appState.gameBoard.compactMap { $0 }.filter { $0.player == lastMove.player }.map(\.boardIndex))
        for pattern in winPatterns where pattern.isSubset(of: playerMovesIndexes) {
            return true
        }
        
        return false
    }
    
    private var isDrawCondition: Bool {
        return appState.gameBoard.compactMap { $0 }.count == appState.gameBoard.count
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
        
        processNextMove()
    }
    
    func restartGame() {
        isEvenMove = false
        lastMove = nil
        appState.gameBoard = Array(repeating: nil, count: 9)
    }
}

// MARK: - Internals

private extension GameProgressServiceImpl {
    
    enum Constants {
        
        static let aiThrottle: Double = 0.4
    }
    
    func processNextMove() {
        if isWinCondition {
            if let lastMove = lastMove {
                winPublisher.send(lastMove)
            }

            return
        }
        
        if isDrawCondition {
            drawPublisher.send()
            return
        }
        
        if isEvenMove,
           case GameType.singlePlayer = appState.profile.gameType {
            fireAIMove()
        }
    }
    
    func fireAIMove() {
        isAIСonsideringMovePublisher.send(true)
        let moveIndex: Int = aiEngine.produceMoveIndex(for: appState.gameBoard)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.aiThrottle) {
            self.makeMove(at: moveIndex)
            self.isAIСonsideringMovePublisher.send(false)
        }
    }
}
