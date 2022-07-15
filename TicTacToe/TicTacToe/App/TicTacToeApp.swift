//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: .init(diContainer: diContainer()))
        }
    }
    
    private func diContainer() -> DIContainer {
        let appState: AppState = AppState()
        let services: DIContainer.Services = DIContainer.Services()
        
        return DIContainer(appState: appState, services: services)
    }
}
