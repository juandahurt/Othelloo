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
    
    /// Game log
    var log = Log()
    
    /// Is the game over?
    var isOver: Bool = false
    
    /// user must pass the turn?
    var userMustPassTheTurn: Bool = false
    
    /// game difficulty
    enum Difficulty {
        case easy, medium, hard
    }
    
    init() {
        initState()
        initCostTable()
        initPossibleMoves()
    }
    
    init(isOver: Bool, userScore: Int, cpuScore: Int) {
        self.init()
        self.isOver = isOver
        self.userScore = userScore
        self.cpuScore = cpuScore
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
        possibleMovements = findMovements(for: .user)
    }
    
    // MARK: - Game Implementation
    func actions(for player: Player, at state: State) -> [State] {
        let movements = self.findMovements(for: player)
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
        let cpuMovements = findMovements(for: .cpu)
        let userMovements = findMovements(for: .user)
        return cpuMovements.isEmpty && userMovements.isEmpty
    }
    
    /// Returns all the allowable movements for the user.
    func findMovements(for player: Player) -> [Movement] {
        OthelloMovementsFinder.findMovements(for: player, directions: Movement.Direction.directions, in: state)
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
        log.add("Waiting for machine to move...", isFromTheMachine: false)
        log.add(LogMessage.random(type: .afterUserMovement).text)
        possibleMovements.removeAll()
    }
    
    /// Excecutes a cpu movement using the alpha-beta algorithm
    /// - Parameter difficulty: ai difficulty
    mutating func cpuTurn(difficulty: Difficulty) {
        if difficulty == .easy {
            if let movement = findMovements(for: .cpu).randomElement() {
                self.state = OthelloMovementExcecutor().excecute(movement: movement, by: .cpu, in: self.state)
            }
        } else {
            let depth: Int
            if difficulty == .medium { depth = 0 }
            else { depth = 2 }
            let alphaBeta = AlphaBeta(game: self, depth: depth)
            self.state = alphaBeta.run(state: self.state)
        }
        isOver = isTerminal(state: state)
        updateScores()
        if isOver { return }
        possibleMovements = findMovements(for: .user)
        userMustPassTheTurn = possibleMovements.isEmpty
        log.add(LogMessage.random(type: .afterCpuMovement).text)
        log.add("Waiting for user to move...", isFromTheMachine: false)
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
    
    mutating func passTurnToCpu() {
        userMustPassTheTurn = false
    }
    
    mutating func restart() {
        self = .init()
    }
}
