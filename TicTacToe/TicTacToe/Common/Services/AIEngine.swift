//
//  AIEngine.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 16.07.2022.
//

import Foundation

protocol AIEngine {
    
    func set(winPatterns patterns: Set<Set<Int>>)
    func produceMoveIndex(for gameBoard: [Move?]) -> Int
}

/// AI is smart but not unbeatable!
///
/// 1. If AI can win, then win
/// 2. If AI can't win, then block
/// 3. If AI can't block, then take middle square
/// 4. If AI can't take middle square, take random available square
final class AIEngineImpl: AIEngine {
    
    private var winPatterns: Set<Set<Int>>?
    
    func set(winPatterns patterns: Set<Set<Int>>) {
        winPatterns = patterns
    }
    
    func produceMoveIndex(for gameBoard: [Move?]) -> Int {
        if let winMoveIndex: Int = produceWinMove(for: gameBoard) {
            return winMoveIndex
        }
        
        if let blockMoveIndex: Int = produceBlockMove(for: gameBoard) {
            return blockMoveIndex
        }
        
        if let middleSquareMoveIndex: Int = produceMiddleSquareMove(for: gameBoard) {
            return middleSquareMoveIndex
        }
        
        if let randomMoveIndex: Int = produceRandomMove(for: gameBoard) {
            return randomMoveIndex
        }
        
        return 0
    }
}

// MARK: - Internals

private extension AIEngineImpl {
     
    enum Constants {
        
        static let middleSquareIndex: Int = 4
    }
    
    func produceWinMove(for gameBoard: [Move?]) -> Int? {
        guard let winPatterns = winPatterns else {
            return nil
        }
        
        let moves: [Move] = gameBoard.compactMap { $0 }
        let aiMovesIndexes: Set<Int> = Set(moves.filter { $0.player == .computer }.map(\.boardIndex))
        for pattern in winPatterns {
            let positions = pattern.subtracting(aiMovesIndexes)
            if positions.count == 1,
               !moves.contains(where: { $0.boardIndex == positions.first }) {
                return positions.first
            }
        }
        
        return nil
    }
    
    func produceBlockMove(for gameBoard: [Move?]) -> Int? {
        guard let winPatterns = winPatterns else {
            return nil
        }
        
        let moves: [Move] = gameBoard.compactMap { $0 }
        let playerMovesIndexes: Set<Int> = Set(moves.filter { $0.player == .player1 }.map(\.boardIndex))
        for pattern in winPatterns {
            let positions = pattern.subtracting(playerMovesIndexes)
            if positions.count == 1,
               !moves.contains(where: { $0.boardIndex == positions.first }) {
                return positions.first
            }
        }
        
        return nil
    }
    
    func produceMiddleSquareMove(for gameBoard: [Move?]) -> Int? {
        guard gameBoard[Constants.middleSquareIndex] == nil else {
            return nil
        }
        
        return Constants.middleSquareIndex
    }
    
    func produceRandomMove(for gameBoard: [Move?]) -> Int? {
        let movesIndexes: Set<Int> = Set(gameBoard.compactMap(\.?.boardIndex))
        let freeMovesIndexes: Set<Int> = Set(0..<gameBoard.count).subtracting(movesIndexes)
        
        return freeMovesIndexes.randomElement()
    }
}
