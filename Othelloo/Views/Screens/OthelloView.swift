//
//  OthelloView.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct OthelloView: View {
    @StateObject var othelloVM: OthelloVM
    var intersitial = Interstitial()
    
    var background: some View {
        Rectangle()
            .fill(backgroundColor)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
    
    func scores() -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 50) / 8
        return ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Green-Light"))
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Green"))
                .padding(5)
            HStack {
                Spacer()
                VStack {
                    Circle()
                        .fill(Color("Black"))
                        .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                    Text("\(othelloVM.userScore)")
                }
                Spacer()
                VStack {
                    Circle()
                        .fill(Color("White"))
                        .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                    Text("\(othelloVM.cpuScore)")
                }
                Spacer()
            }
        }
        .foregroundColor(Color("White"))
        .font(.system(size: 16, weight: .bold, design: .default))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                VStack {
                    HStack {
                        scores()
                        Spacer(minLength: 15)
                        ActionsContainer(newGameOnTap: {
                            othelloVM.restart()
                            intersitial.showAd()
                        })
                    }
                        .padding(.horizontal, 15)
                    Spacer()
                    Board(state: othelloVM.currentState, possibleMovements: othelloVM.possibleMovements, possibleMovementOnTap: { movement in
                        othelloVM.userTurn(movement: movement)
                        othelloVM.cpuTurn()
                    })
                    Spacer()
                    Terminal(logs: othelloVM.logs)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .aspectRatio(contentMode: .fit)
                Group {
                    if othelloVM.isOver {
                        GameOver(userScore: othelloVM.userScore, cpuScore: othelloVM.cpuScore) {
                            othelloVM.restart()
                            intersitial.showAd()
                        }
                        .animation(.linear)
                        .transition(.slide)
                    }
                    if othelloVM.userMustPassTheTurn {
                        NoMovements {
                            othelloVM.passTurnToCpu()
                        }
                        .animation(.linear)
                        .transition(.slide)
                    }
                }
            }.navigationBarHidden(true)
        }
    }
    
    let backgroundColor = Color("Green")
}
