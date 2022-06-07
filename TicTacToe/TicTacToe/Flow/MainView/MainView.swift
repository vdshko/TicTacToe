//
//  MainView.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View { bodyView() }
}

// MARK: - Views

private extension MainView {
    
    enum Constants {
        
        static let columnsCount: Int = 3
        static let interItemSpacing: CGFloat = 15.0
    }
    
    @ViewBuilder func bodyView() -> some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(L10n.App.title)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                GeometryReader { geometry in
                    centeredGameBoardView(for: geometry)
                }
            }
        }
    }
    
    @ViewBuilder func centeredGameBoardView(for geometry: GeometryProxy) -> some View {
        let isLandscape: Bool = geometry.size.height < geometry.size.width
        if isLandscape {
            HStack {
                Spacer()
                gameBoardView(for: geometry)
                Spacer()
            }
        } else {
            VStack {
                Spacer()
                gameBoardView(for: geometry)
                Spacer()
            }
        }
    }
    
    @ViewBuilder func gameBoardView(for geometry: GeometryProxy) -> some View {
        let minSpace: CGFloat = min(geometry.size.width, geometry.size.height)
        let itemSide: CGFloat = (minSpace - Constants.interItemSpacing * CGFloat(Constants.columnsCount - 1)) / CGFloat(Constants.columnsCount)
        let gridColumns: [GridItem] = Array(repeating: .init(.flexible()), count: Constants.columnsCount)
        LazyVGrid(columns: gridColumns, spacing: Constants.interItemSpacing) {
            ForEach(0 ..< viewModel.moves.count, id: \.self) { index in
                item(id: index, side: itemSide)
            }
        }
        .frame(width: minSpace, height: minSpace)
    }
    
    @ViewBuilder func item(id: Int, side: CGFloat) -> some View {
        ZStack {
            Circle()
                .frame(width: side, height: side)
                .foregroundColor(Asset.Colors.boardItem.color)
            if let move = viewModel.moves[id] {
                move.gameFigure.image
                    .resizable()
                    .frame(width: side * 0.5, height: side * 0.5)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            viewModel.handleItemTap(for: id)
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MainView(viewModel: .init(diContainer: .preview))
                .previewInterfaceOrientation(.portrait)
            MainView(viewModel: .init(diContainer: .preview))
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
#endif
