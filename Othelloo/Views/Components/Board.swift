//
//  Board.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Board: View {
    func cell(row: Int, col: Int) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 50) / 8
        
        return Rectangle()
            .fill((row + col) % 2 == 0 ? brownColor : brownLightColor)
            .frame(width: cellWidth, height: cellWidth)
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
    
    let greenLightColor = Color("Green-Light")
    let brownColor = Color("Brown")
    let brownLightColor = Color("Brown-Light")
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board()
    }
}
