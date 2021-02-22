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
    
    var possibleMovements: [Movement] {
        othello.possibleMovements
    }
    
    var userScore: Int {
        othello.userScore
    }
    
    var cpuScore: Int {
        othello.cpuScore
    }
    
    var log: Log {
        othello.log
    }
    
    var isOver: Bool {
        othello.isOver
    }
    
    var userMustPassTheTurn: Bool {
        othello.userMustPassTheTurn
    }
    
    func userTurn(movement: Movement) {
        othello.userTurn(movement: movement)
    }
    
    func cpuTurn(difficulty: Othello.Difficulty) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 0.5...1)) {
            self.othello.cpuTurn(difficulty: difficulty)
        }
    }
    
    func passTurnToCpu(difficulty: Othello.Difficulty) {
        othello.passTurnToCpu()
        DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: 0.5...1)) {
            self.othello.cpuTurn(difficulty: difficulty)
        }
    }
    
    func restart() {
        othello.restart()
    }
}
