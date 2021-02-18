//
//  OthelloGame.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

class OthelloVM: ObservableObject {
    @Published private var othello: Othello
    
    init() {
        othello = Othello()
    }
    
    var currentState: Othello.State {
        othello.state
    }
    
    var possibleMoves: [Movement] {
        othello.possibleMovements
    }
    
    var userScore: Int {
        othello.userScore
    }
    
    var cpuScore: Int {
        othello.cpuScore
    }
    
    var logs: [Log] {
        othello.logs
    }
    
    func userTurn(movement: Movement) {
        othello.userTurn(movement: movement)
    }
    
    func cpuTurn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 1...2)) {
            self.othello.cpuTurn()
        }
    }
}
