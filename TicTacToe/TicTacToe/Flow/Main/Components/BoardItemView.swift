//
//  BoardItemView.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 15.07.2022.
//

import SwiftUI

struct BoardItemView: View {
    
    let move: Move?
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Asset.Colors.Specific.boardItem.color)
            if let move = move {
                move.gameFigure.image
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.5)
                    .foregroundColor(.white)
            }
        }
    }
}

struct BoardItemView_Previews: PreviewProvider {
    
    private static let moves: [Move?] = [
        nil,
        Move(boardIndex: 0, player: .player1, gameFigure: .xmark),
        Move(boardIndex: 1, player: .player1, gameFigure: .circle)
    ]
    
    static var previews: some View {
        VStack {
            ForEach(moves, id: \.self) {
                BoardItemView(move: $0)
            }
        }
    }
}
