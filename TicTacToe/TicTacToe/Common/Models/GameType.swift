//
//  GameType.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 17.07.2022.
//

import Foundation

enum GameType: Identifiable, CaseIterable {
    
    case singlePlayer
    case multiPlayer
    
    var id: String {
        return rawValue
    }
    
    var rawValue: String {
        switch self {
        case .singlePlayer: return L10n.Profile.GameType.singlePlayer
        case .multiPlayer: return L10n.Profile.GameType.multiPlayer
        }
    }
}
