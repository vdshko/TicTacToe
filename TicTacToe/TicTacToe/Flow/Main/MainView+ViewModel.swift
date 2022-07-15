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
        
        private let cancelBag: CancelBag = CancelBag()
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            setupBinding()
        }
        
        func openProfile() {}
        
        func handleItemTap(for id: Int) {
            guard diContainer.appState.gameBoard[id] == nil else {
                return
            }
            
            diContainer.appState.gameBoard[id] = Move(
                boardIndex: id,
                player: Move.Player.human,
                gameFigure: isEvenTurn ? Move.GameFigure.circle : Move.GameFigure.xmark
            )
        }
        
        private func setupBinding() {
            diContainer.appState.$gameBoard
                .assignWeak(to: \.moves, on: self)
                .store(in: cancelBag)
            diContainer.appState.$gameBoard
                .dropFirst()
                .sink { [weak self] _ in
                    self?.isEvenTurn.toggle()
                }
                .store(in: cancelBag)
        }
    }
}
