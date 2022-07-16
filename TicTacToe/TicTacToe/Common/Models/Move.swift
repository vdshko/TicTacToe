//
//  Move.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 07.06.2022.
//

import SwiftUI

struct Move: Hashable {
    
    let boardIndex: Int
    let player: Player
    let gameFigure: GameFigure
}

extension Move {
    
    enum Player {
        
        case player1, player2
        case computer
        
        var rawValue: String {
            switch self {
            case .player1: return L10n.Player.first
            case .player2: return L10n.Player.second
            case .computer: return L10n.Player.computer
            }
        }
    }
    
    enum GameFigure: String {
        
        case circle
        case xmark
        
        var image: Image {
            return Image(systemName: rawValue)
        }
    }
}
