//
//  MainView+ViewModel.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import class Foundation.DispatchQueue
import Combine

extension MainView {
    
    final class MainViewModel: ObservableObject {
        
        @Published var isAlertPresented: Bool = false
        @Published var isGameBoardDisabled: Bool = false
        @Published var isProfileShown: Bool = false
        
        @Published private(set) var moves: [Move?] = []
        @Published private(set) var isBoardLocked: Bool = false
        
        var alertTitle: String = ""
        
        private let cancelBag: CancelBag = CancelBag()
        private let diContainer: DIContainer
        
        private var profileViewModelCancellable: AnyCancellable?
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            setupBinding()
        }
        
        func handleProfileTap() {
            isProfileShown = true
        }
        
        func handleAlertTap() {
            diContainer.services.gameProgressService.restartGame()
        }
        
        func handleItemTap(for index: Int) {
            guard !isBoardLocked else {
                return
            }
            
            diContainer.services.gameProgressService.makeMove(at: index)
        }
        
        func profileViewModel() -> ProfileView.ProfileViewModel {
            return ProfileView.ProfileViewModel(diContainer: diContainer)
        }
        
        private func setupBinding() {
            diContainer.appState.$gameBoard
                .receive(on: DispatchQueue.main)
                .assignWeak(to: \.moves, on: self)
                .store(in: cancelBag)
            diContainer.services.gameProgressService.winPublisher
                .map { L10n.Alert.Title.win($0.player.rawValue) }
                .merge(
                    with: diContainer.services.gameProgressService.drawPublisher
                        .map { _ in L10n.Alert.Title.draw }
                )
                .receive(on: DispatchQueue.main)
                .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
                .assignWeak(to: \.alertTitle, on: self)
                .store(in: cancelBag)
            diContainer.services.gameProgressService.winPublisher
                .map { _ in true }
                .merge(
                    with: diContainer.services.gameProgressService.drawPublisher
                        .map { _ in true }
                )
                .receive(on: DispatchQueue.main)
                .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
                .assignWeak(to: \.isAlertPresented, on: self)
                .store(in: cancelBag)
            diContainer.services.gameProgressService.isAIСonsideringMovePublisher
                .receive(on: DispatchQueue.main)
                .assignWeak(to: \.isGameBoardDisabled, on: self)
                .store(in: cancelBag)
            $isProfileShown
                .removeDuplicates()
                .assignWeak(to: \.isProfileShown, on: diContainer.appState)
                .store(in: cancelBag)
            diContainer.appState.$isProfileShown
                .assignWeak(to: \.isProfileShown, on: self)
                .store(in: cancelBag)
        }
    }
}
