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
    
    /// Current player
    var player: Player = .user
    
    /// Movements that user can make
    var possibleMovements: [Movement] = []
    
    /// Contains the cost of every postion on the board.
    var costTable: [[Int]] = []
    
    init() {
        initState()
        initCostTable()
        initPossibleMoves()
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
    
    mutating private func initPossibleMoves() {
        possibleMovements = moves()
    }
    
    // MARK: - Game Implementation
    func actions(for player: Player, at state: State) -> [State] {
        []
    }
    
    func utility(of state: State, for player: Player) -> Int {
        0
    }
    
    func isTerminal(state: State) -> Bool {
        true
    }
    
    /// Returns all the allowable moves for the user.
    mutating func moves() -> [Movement] {
        guard player != .none else { return [] }
        // find the user positions
        var userPositions: [Position] = []
        var moves: [Movement] = []
        for row in 0..<8 {
            for col in 0..<8 {
                let position = state[row][col]
                if position.player == .user { userPositions.append(position) }
            }
        }
        let movesChecker = OthelloMovementChecker()
        for position in userPositions {
            for direction in Movement.Direction.directions {
                if let move = movesChecker.checkIfUserCanMove(from: position, to: direction, state: state) {
                    moves.append(move)
                }
            }
        }
        return moves
    }
}
