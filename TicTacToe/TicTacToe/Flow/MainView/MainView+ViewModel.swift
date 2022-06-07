//
//  MainView+ViewModel.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import Combine

extension MainView {
    
    final class MainViewModel: ObservableObject {
        
        @Published var moves: [Move?] = Array(repeating: nil, count: 9)
        private var isEvenTurn: Bool = false
        
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
        }
        
        func handleItemTap(for id: Int) {
            guard diContainer.appState.gameBoard[id] == nil else {
                return
            }
            
            diContainer.appState.gameBoard[id] = Move(
                boardIndex: id,
                player: Move.Player.human,
                gameFigure: isEvenTurn ? Move.GameFigure.circle : Move.GameFigure.xmark
            )
            moves = diContainer.appState.gameBoard
            isEvenTurn.toggle()
        }
    }
}
