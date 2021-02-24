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
    var possibleMovementOnTap: (Movement) -> Void
    @State private var cellWidth = (UIScreen.main.bounds.width - 50 ) / 8
    
    func cell(row: Int, col: Int) -> some View {
        let player = state[row][col].player
        let possibleMovement = possibleMovements.first(where: { $0.to.row == row && $0.to.col == col })
        
        return ZStack {
            Rectangle()
                .fill((row + col) % 2 == 0 ? brownColor : brownLightColor)
                .frame(width: cellWidth, height: cellWidth)
            Group() {
                if player != .none {
                    Circle()
                        .fill(player == .user ? userColor : cpuColor)
                        .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                        .animation(.spring())
                } else {
                    Circle()
                        .fill(possibleMovement != nil ? possibleMovementsColor : Color.clear)
                        .frame(width: cellWidth * 0.15, height: cellWidth * 0.15)
                }
            }
        }.onTapGesture {
            if let movement = possibleMovement {
                possibleMovementOnTap(movement)
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
            }.cornerRadius(5)
        }
    }
    
    // MARK: - UI Constants
    let possibleMovementsColor = Color("Black").opacity(0.3)
    let userColor = Color("Black")
    let cpuColor = Color("White")
    let greenLightColor = Color("Green-Light")
    let brownColor = Color("Brown")
    let brownLightColor = Color("Brown-Light")
}

struct BoardPreview: PreviewProvider {
    static let othelloVM = OthelloVM(game: Othello())
    
    static var previews: some View {
        OthelloView(othelloVM: othelloVM)
            .previewDevice("iPhone 8")
    }
}
