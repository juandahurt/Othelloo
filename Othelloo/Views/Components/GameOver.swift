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
    @State private var borderColor: Color = .clear
    @State private var backgroundColor: Color = .clear
    @State private var title: String = ""
    
    init(userScore: Int, cpuScore: Int, onTap: @escaping () -> Void) {
        self.userScore = userScore
        self.cpuScore = cpuScore
        self.onTap = onTap
    }
    
    func chooseCorrectDesign() {
        if userScore > cpuScore {
            borderColor = Color("Gold-Dark")
            backgroundColor = Color("Gold")
            title = "You won!"
        } else if userScore == cpuScore {
            borderColor = Color("White-Dark")
            backgroundColor = Color("White")
            title = "It's a draw."
        } else {
            borderColor = Color("Red-Dark")
            backgroundColor = Color("Red")
            title = "You lost."
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(borderColor)
                .cornerRadius(5)
            Rectangle()
                .fill(backgroundColor)
                .cornerRadius(5)
                .padding(5)
            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .id("Title")
                Text("Tap here to dismiss this message.")
                    .font(.system(size: fontSize, weight: .regular, design: .monospaced))
            }
                .foregroundColor(Color("Black"))
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height * 0.1)
        .onTapGesture {
            onTap()
        }
        .onAppear {
            chooseCorrectDesign()
        }
    }
    
    let titleFontSize = UIScreen.main.bounds.height * 0.02
    let fontSize = UIScreen.main.bounds.height * 0.015
}

struct GameOverPreviews: PreviewProvider {
    static let othelloVM = OthelloVM(game: Othello(isOver: true, userScore: 5, cpuScore: 3))
    
    static var previews: some View {
        OthelloView(othelloVM: othelloVM)
            .previewDevice("iPhone 11 Pro Max")
    }
}
