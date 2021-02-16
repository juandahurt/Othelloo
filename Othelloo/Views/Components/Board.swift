//
//  Board.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Board: View {
    var state: Othello.State
    
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
    let userColor = Color("White")
    let cpuColor = Color("Black")
    let greenLightColor = Color("Green-Light")
    let brownColor = Color("Brown")
    let brownLightColor = Color("Brown-Light")
}
