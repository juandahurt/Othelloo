//
//  OthelloView.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct OthelloView: View {
    @StateObject var othelloVM: OthelloVM
    
    var background: some View {
        Rectangle()
            .fill(backgroundColor)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
    
    func scores() -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 50) / 8
        return HStack(spacing: 100) {
            VStack {
                Circle()
                    .fill(Color("White"))
                    .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                Text("\(othelloVM.userScore)")
            }
            VStack {
                Circle()
                    .fill(Color("Black"))
                    .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                Text("\(othelloVM.cpuScore)")
            }
        }
        .foregroundColor(Color("White"))
        .font(.system(size: 16, weight: .bold, design: .default))
    }
    
    var body: some View {
        ZStack {
            background
            VStack {
                scores()
                Spacer()
                Board(state: othelloVM.currentState, possibleMovements: othelloVM.possibleMoves, possibleMovementOnTap: { movement in
                    othelloVM.userTurn(movement: movement)
                    othelloVM.cpuTurn()
                })
                Spacer()
                Terminal(logs: othelloVM.logs)
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            .aspectRatio(contentMode: .fit)
        }
    }
    
    let backgroundColor = Color("Green")
}
