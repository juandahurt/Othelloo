//
//  MovesChecker.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

/// Defines the functions for a move checker.
protocol MovementChecker {
    associatedtype State
    
    /// Cheks if the user can make a move given a certain direction.
    /// - Parameters:
    ///   - position: initial position
    ///   - direction: move direction
    ///   - state: current state of the game
    /// - Returns: All the possible movements.
    func checkIfUserCanMove(from position: Position, to direction: Movement.Direction, state: State) -> Movement?
}
