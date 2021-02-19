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
    var newGameOnTap: () -> Void
    
    func getCorrectTitle() -> String {
        if userScore > cpuScore {
            return "Congratulations."
        } else if userScore == cpuScore {
            return "It's a draw!"
        } else {
            return "I'm sorry."
        }
    }
    
    func getCorrectText() -> String {
        if userScore > cpuScore {
            return "You've won."
        } else if userScore == cpuScore {
            return "I was not expecting that..."
        } else {
            return "You've lost."
        }
    }
    
    var newGameButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Green"))
            Text("New game")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(Color("White"))
        }
        .frame(width: 100, height: 40)
        .onTapGesture {
            newGameOnTap()
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
                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                Text(getCorrectText())
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                    .padding(.bottom, 5)
            }
                .foregroundColor(Color("White"))
            newGameButton
                .offset(x: 0, y: 60)
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 120)
    }
}
