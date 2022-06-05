//
//  MainView.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        Text(L10n.App.title)
            .padding()
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(viewModel: .init(diContainer: .preview))
    }
}
#endif
