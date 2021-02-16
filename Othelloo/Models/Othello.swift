//
//  Othello.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

struct Othello: Game {
    typealias State = [[Position]]
    
    /// Current state of the game
    var state: State = []
    
    /// Contains the cost of every postion on the board.
    var costTable: [[Int]] = []
    
    init() {
        initState()
        initCostTable()
    }
    
    // MARK: - Initalizers
    mutating private func initState() {
        state = []
        for row in 0..<8 {
            var stateRow: [Position] = []
            for col in 0..<8 {
                stateRow.append(Position(row: row, col: col, player: .none))
            }
            state.append(stateRow)
        }
        state[3][3].player = .user
        state[3][4].player = .cpu
        state[4][3].player = .cpu
        state[4][4].player = .user
    }
    
    mutating private func initCostTable() {
        costTable = [
            [100, -20, 10,  5,  5, 10, -20, 100],
            [-20, -50, -2, -2, -2, -2, -50, -20],
            [ 10, -2,  -1, -1, -1, -1,  -2,  10],
            [  5, -2,  -1, -1, -1, -1,  -2,   5],
            [  5, -2,  -1, -1, -1, -1,  -2,   5],
            [ 10, -2,  -1, -1, -1, -1,  -2,  10],
            [-20, -50, -2, -2, -2, -2, -50, -20],
            [100, -20, 10,  5,  5, 10, -20, 100]
        ]
    }
    
    // MARK: - Game Implementation
    func moves(for player: Player, at state: State) -> [Move] {
//        guard player != .none else { return [] }
//        var oponent: Player
//        if player == .user { oponent = .cpu }
//        else { oponent = .user }
        []
    }
    
    func actions(for player: Player, at state: State) -> [State] {
        []
    }
    
    func utility(of state: State, for player: Player) -> Int {
        0
    }
    
    func isTerminal(state: State) -> Bool {
        true
    }
}
