//
//  MainView+ViewModel.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import Combine

extension MainView {
    
    final class MainViewModel: ObservableObject {
        
        @Published private(set) var moves: [Move?] = []
        
        private var isEvenTurn: Bool = false
        private var cancellable: Set<AnyCancellable> = Set()
        
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            setupBinding()
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
            isEvenTurn.toggle()
        }
        
        private func setupBinding() {
            diContainer.appState.$gameBoard
                .sink { [weak self] in
                    self?.moves = $0
                }
                .store(in: &cancellable)
        }
    }
}
