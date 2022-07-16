import SwiftUI
import Combine

extension ProfileView {
    
    final class ProfileViewModel: ObservableObject {
        
        @Published var gameType: GameType
        
        private let cancelBag: CancelBag = CancelBag()
        private let diContainer: DIContainer
        
        init(diContainer: DIContainer) {
            self.diContainer = diContainer
            self.gameType = diContainer.appState.gameType
            setupBinding()
        }
        
        func handleXmarkTap() {
            diContainer.appState.isProfileShown = false
        }
        
        func handleRestartTap() {
            diContainer.services.gameProgressService.restartGame()
            diContainer.appState.isProfileShown = false
        }
        
        private func setupBinding() {
            $gameType
                .dropFirst()
                .sink { [weak diContainer] _ in
                    diContainer?.services.gameProgressService.restartGame()
                }
                .store(in: cancelBag)
            $gameType
                .dropFirst()
                .assignWeak(to: \.gameType, on: diContainer.appState)
                .store(in: cancelBag)
        }
    }
}
