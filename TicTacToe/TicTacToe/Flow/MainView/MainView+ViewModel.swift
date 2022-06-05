//
//  MainView+ViewModel.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import Combine

extension MainView {
    
    final class MainViewModel: ObservableObject {
        
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
        }
    }
}
