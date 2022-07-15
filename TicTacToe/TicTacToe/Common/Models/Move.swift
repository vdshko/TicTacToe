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
        
        case human
    }
    
    enum GameFigure: String {
        
        case circle
        case xmark
        
        var image: Image {
            return Image(systemName: rawValue)
        }
    }
}
