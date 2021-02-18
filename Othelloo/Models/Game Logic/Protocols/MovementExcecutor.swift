//
//  MovementExcecutor.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

protocol MovementExcecutor {
    associatedtype State
    
    /// Excecutes a movement
    /// - Parameters:
    ///   - movement: movement to be excecuted
    ///   - player: current player
    ///   - state: current state of the game
    func excecute(movement: Movement, by player: Player, in state: State) -> State
}
