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
    
    /// Movements that user can make
    var possibleMovements: [Movement] = []
    
    /// Contains the cost of every postion on the board.
    var costTable: [[Int]] = []
    
    /// Number of positions that the user posses
    var userScore: Int = 2
    
    /// Number of positions that the machine posses
    var cpuScore: Int = 2
    
    /// Game logs
    var logs: [Log] = []
    
    /// Is the game over?
    var isOver: Bool = false
    
    /// user must pass the turn?
    var userMustPassTheTurn: Bool = false
    
    init() {
        initState()
        initCostTable()
        initPossibleMoves()
        initLogs()
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
        state[3][3].player = .cpu
        state[3][4].player = .user
        state[4][3].player = .user
        state[4][4].player = .cpu
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
        possibleMovements = movements(for: .user)
    }
    
    mutating private func initLogs() {
        logs.append(Log(id: 0, message: "Welcome.", isFromTheMachine: false))
        logs.append(Log(id: 1, message: "Those little circles represent the places where you can move.", isFromTheMachine: false))
        logs.append(Log(id: 2, message: "Waiting for user to move...", isFromTheMachine: false))
    }
    
    // MARK: - Game Implementation
    func actions(for player: Player, at state: State) -> [State] {
        let movements = self.movements(for: player)
        var actions = [State]()
        let excecutor = OthelloMovementExcecutor()
        for movement in movements {
            actions.append(excecutor.excecute(movement: movement, by: player, in: state))
        }
        return actions
    }
    
    func utility(of state: State, for player: Player) -> Int {
        var playerSum = 0
        var oponentSum = 0
        let oponent: Player
        if player == .cpu { oponent = .user }
        else { oponent = .cpu }
        for row in 0..<8 {
            for col in 0..<8 {
                if state[row][col].player == player {
                    playerSum += costTable[row][col]
                } else if state[row][col].player == oponent {
                    oponentSum += costTable[row][col]
                }
            }
        }
        return playerSum - oponentSum
    }
    
    func isTerminal(state: State) -> Bool {
        let cpuMovements = movements(for: .cpu)
        let userMovements = movements(for: .user)
        return cpuMovements.isEmpty && userMovements.isEmpty
    }
    
    /// Returns all the allowable movements for the user.
    func movements(for player: Player) -> [Movement] {
        // find the user positions
        var userPositions: [Position] = []
        var movements: [Movement] = []
        for row in 0..<8 {
            for col in 0..<8 {
                let position = state[row][col]
                if position.player == player { userPositions.append(position) }
            }
        }
        let movesChecker = OthelloMovementChecker()
        for position in userPositions {
            for direction in Movement.Direction.directions {
                if let movement = movesChecker.checkIfPlayerCanMove(from: position, to: direction, player: player, state: state) {
                    movements.append(movement)
                }
            }
        }
        return movements
    }
    
    /// Excecutes an user movement that modifes the current state
    /// - Parameter movement: movement to be excecuted
    mutating func userTurn(movement: Movement) {
        let excecutor = OthelloMovementExcecutor()
        let movementsToBeExcecuted = possibleMovements.filter({ $0.to == movement.to })
        var movementIndex = 0
        while movementIndex < movementsToBeExcecuted.count {
            self.state = excecutor.excecute(movement: movementsToBeExcecuted[movementIndex], by: .user, in: self.state)
            movementIndex += 1
        }
        updateScores()
        isOver = isTerminal(state: state)
        if isOver { return }
        if logs.count > 3 {
            logs.removeSubrange(0...1)
        }
        updateLogsIds()
        logs.append(Log(id: logs.count, message: "Waiting for machine to move...", isFromTheMachine: false))
        possibleMovements.removeAll()
        logs.append(Log(id: logs.count, message: LogMessage.random(type: .afterUserMovement).text))
    }
    
    /// Excecutes a cpu movement using the alpha-beta algorithm
    mutating func cpuTurn() {
        let alphaBeta = AlphaBeta(game: self, depth: 0)
        self.state = alphaBeta.run(state: self.state)
        isOver = isTerminal(state: state)
        updateScores()
        if isOver { return }
        possibleMovements = movements(for: .user)
        userMustPassTheTurn = possibleMovements.isEmpty
        if logs.count > 3 {
            logs.removeSubrange(0...1)
        }
        updateLogsIds()
        logs.append(Log(id: logs.count, message: LogMessage.random(type: .afterCpuMovement).text))
        logs.append(Log(id: logs.count, message: "Waiting for user to move...", isFromTheMachine: false))
    }
    
    /// Updates the scores of the two players
    mutating private func updateScores() {
        userScore = 0
        cpuScore = 0
        for row in 0..<8 {
            for col in 0..<8 {
                let position = state[row][col]
                if position.player == .user { userScore += 1 }
                if position.player == .cpu { cpuScore += 1 }
            }
        }
    }
    
    mutating private func updateLogsIds() {
        for logIndex in logs.indices {
            logs[logIndex].id = logIndex
        }
    }
    
    mutating func passTurnToCpu() {
        userMustPassTheTurn = false
    }
    
    mutating func restart() {
        self = .init()
    }
}
