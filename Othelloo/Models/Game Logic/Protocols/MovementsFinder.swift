//
//  MovementsFinder.swift
//  Othelloo
//
//  Created by juandahurt on 21/02/21.
//

import Foundation

protocol MovementsFinder {
    associatedtype State
    
    /// Find all the possible movements for the current player
    /// - Parameters:
    ///   - player: current player
    ///   - directions: allowable directions
    ///   - state: current state
    static func findMovements(for player: Player, directions: [Movement.Direction], in state: State) -> [Movement]
    
    /// Cheks if the current player can make a move given a certain direction.
    /// - Parameters:
    ///   - position: initial position
    ///   - direction: move direction
    ///   - player: current player
    ///   - state: current state of the game
    /// - Returns: The movement.
    static func checkIfPlayerCanMove(from position: Position, to direction: Movement.Direction, player: Player, state: State) -> Movement?
}
