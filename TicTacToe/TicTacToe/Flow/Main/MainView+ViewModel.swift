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
        @Published private(set) var isBoardLocked: Bool = false
        
        private let cancelBag: CancelBag = CancelBag()
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            setupBinding()
        }
        
        func openProfile() {}
        
        func handleItemTap(for index: Int) {
            guard !isBoardLocked else {
                return
            }
            
            diContainer.services.gameProgressService.makeMove(at: index)
        }
        
        private func setupBinding() {
            diContainer.appState.$gameBoard
                .receive(on: DispatchQueue.main)
                .assignWeak(to: \.moves, on: self)
                .store(in: cancelBag)
        }
    }
}
