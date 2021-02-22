//
//  GameOver.swift
//  Othelloo
//
//  Created by juandahurt on 18/02/21.
//

import SwiftUI

struct GameOver: View {
    var userScore: Int
    var cpuScore: Int
    var onTap: () -> Void
    
    func getCorrectTitle() -> String {
        if userScore > cpuScore {
            return "You won!"
        } else if userScore == cpuScore {
            return "It's a draw."
        } else {
            return "You lost."
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Black"))
                .cornerRadius(5)
            Rectangle()
                .fill(Color("Black-Dark"))
                .cornerRadius(5)
                .padding(5)
            VStack(spacing: 10) {
                Text(getCorrectTitle())
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                Text("Tap here to dismiss this message.")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
            }
                .foregroundColor(Color("White"))
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 120)
        .onTapGesture {
            onTap()
        }
    }
}
