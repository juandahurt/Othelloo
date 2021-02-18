//
//  AlphaBeta.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation


/// Implementation of the Alpha-beta algorithm.
struct AlphaBeta<T: Game> {
    /// The game where the algorithm will be used on.
    var game: T
    
    /// Maximum depth.
    var depth: Int
    
    
    /// Executes the Alpha-beta algorithm
    /// - Parameter state: current state of the game
    /// - Parameter depth: maximum depth
    /// - Returns: The best action for the machine
    func run(state: T.State) -> T.State {
        var bestValue: Int = -.infinity
        var bestAction: T.State = state
        var alpha: Int = -.infinity
        var beta: Int = .infinity
        for action in game.actions(for: .cpu, at: state) {
            let value = alphaBetaSearch(state: action, depth: depth, alpha: &alpha, beta: &beta, player: .cpu)
            if value > bestValue {
                bestValue = value
                bestAction = action
            }
        }
        return bestAction
    }
    
    /// Alpha-beta algorithm
    /// - Parameters:
    ///   - state: current state of the game
    ///   - depth: maximum depth
    ///   - alpha: alpha value
    ///   - beta: beta value
    ///   - player: current player
    /// - Returns: The best value.
    func alphaBetaSearch(state: T.State, depth: Int, alpha: inout Int, beta: inout Int, player: Player) -> Int {
        if depth == 0 || game.isTerminal(state: state) {
            return game.utility(of: state, for: player)
        }
        var value: Int
        if player == .user {
            value = -.infinity
            for action in game.actions(for: .user, at: state) {
                value = max(value, alphaBetaSearch(state: action, depth: depth - 1, alpha: &alpha, beta: &beta, player: .cpu))
                alpha = max(alpha, value)
                if alpha >= beta {
                    break
                }
            }
            return value
        } else {
            value = .infinity
            for action in game.actions(for: .cpu, at: state) {
                value = min(value, alphaBetaSearch(state: action, depth: depth - 1, alpha: &alpha, beta: &beta, player: .user))
                beta = min(beta, value)
                if beta <= alpha {
                    break
                }
            }
            return value
        }
    }
}
