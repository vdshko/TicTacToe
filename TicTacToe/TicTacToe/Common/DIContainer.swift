//
//  DIContainer.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

final class DIContainer {
    
    let appState: AppState
    let services: Services
    
    init(appState: AppState, services: Services) {
        self.appState = appState
        self.services = services
    }
}

extension DIContainer {
    
    final class Services {}
}

#if DEBUG
extension DIContainer {
    
    static var preview: DIContainer {
        let appState: AppState = AppState()
        let services: Services = Services()
        
        return DIContainer(appState: appState, services: services)
    }
}
#endif
