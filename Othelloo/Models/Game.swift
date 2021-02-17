//
//  Game.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation


/// Defines the functions of a game.
protocol Game {
    associatedtype State
    
    /// Returns all the allowable actions.
    /// - Parameters:
    ///   - player: current player.
    ///   - state: current state of the game.
    func actions(for player: Player, at state: State) -> [State]
    
    /// Returns the value of the state.
    /// - Parameters:
    ///   - state: current state of the game.
    ///   - player: current player.
    func utility(of state: State, for player: Player) -> Int
    
    /// Returns true if the state is a final state.
    /// - Parameter state: current state of the game.
    func isTerminal(state: State) -> Bool
}
