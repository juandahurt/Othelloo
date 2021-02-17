//
//  Board.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Board: View {
    var state: Othello.State
    var possibleMovements: [Movement]
    
    func cell(row: Int, col: Int) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 50) / 8
        let player = state[row][col].player
        
        return ZStack {
            Rectangle()
                .fill((row + col) % 2 == 0 ? brownColor : brownLightColor)
                .frame(width: cellWidth, height: cellWidth)
            Group() {
                if player != .none {
                    Circle()
                        .fill(player == .user ? userColor : cpuColor)
                        .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                } else {
                    Circle()
                        .fill(possibleMovements.contains(where: { $0.to.row == row && $0.to.col == col }) ? possibleMovesColor : Color.clear)
                        .frame(width: cellWidth * 0.12, height: cellWidth * 0.12)
                }
            }
        }
    }
    
    var holder: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(greenLightColor)
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width - 30)
    }
    
    var body: some View {
        ZStack {
            holder
            VStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            cell(row: row, col: col)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - UI Constants
    let possibleMovesColor = Color("White").opacity(0.7)
    let userColor = Color("White")
    let cpuColor = Color("Black")
    let greenLightColor = Color("Green-Light")
    let brownColor = Color("Brown")
    let brownLightColor = Color("Brown-Light")
}
