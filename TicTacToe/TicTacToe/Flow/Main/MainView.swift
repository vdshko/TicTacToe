//
//  MainView.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 05.06.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private var isLandscape: Bool {
        return verticalSizeClass == .compact
    }
    
    private let gridColumns: [GridItem] = Array(repeating: .init(.flexible()), count: Constants.columnsCount)
    
    var body: some View {
        VStack(spacing: Constants.interItemSpacing) {
            topBarView()
            if isLandscape {
                landscapeGameBoardView()
            } else {
                portraitGameBoardView()
            }
        }
        .padding(.horizontal, Constants.interItemSpacing)
        .unlockRotation()
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    private func topBarView() -> some View {
        ZStack {
            HStack {
                Spacer()
                Button {
                    viewModel.openProfile()
                } label: {
                    Asset.Images.profile.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Asset.Colors.Standard.white.color)
                        .padding(8.0)
                }
            }
            Text(L10n.App.title)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func landscapeGameBoardView() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                HStack {
                    Spacer()
                    gameBoardView(for: geometry)
                    Spacer()
                }
                if viewModel.isBoardLocked {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        }
    }
    
    @ViewBuilder
    private func portraitGameBoardView() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                    gameBoardView(for: geometry)
                    Spacer()
                }
                if viewModel.isBoardLocked {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        }
    }
    
    @ViewBuilder
    private func gameBoardView(for geometry: GeometryProxy) -> some View {
        let minSpace: CGFloat = min(geometry.size.width, geometry.size.height)
        let itemSide: CGFloat = (minSpace - Constants.interItemSpacing * CGFloat(Constants.columnsCount - 1)) / CGFloat(Constants.columnsCount)
        
        LazyVGrid(columns: gridColumns, spacing: Constants.interItemSpacing) {
            ForEach(0 ..< viewModel.moves.count, id: \.self) { index in
                BoardItemView(move: viewModel.moves[index])
                    .frame(width: itemSide, height: itemSide)
                    .onTapGesture {
                        viewModel.handleItemTap(for: index)
                    }
            }
        }
        .frame(width: minSpace, height: minSpace)
    }
}

// MARK: - Internals

private extension MainView {
    
    enum Constants {
        
        static let columnsCount: Int = 3
        static let interItemSpacing: CGFloat = 15.0
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MainView(viewModel: .init(diContainer: .preview))
                .previewInterfaceOrientation(.landscapeLeft)
            MainView(viewModel: .init(diContainer: .preview))
                .previewInterfaceOrientation(.portrait)
        }
    }
}
#endif
