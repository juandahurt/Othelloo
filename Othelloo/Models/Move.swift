//
//  Move.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation


/// Represents a player move.
struct Move {
    /// Position where the move starts.
    var from: Position
    
    /// Positions where the move finishes.
    var to: Position
    
    /// Player who makes the move.
    var player: Player
}


extension Move {
    static let unknown = Move(from: .outsideOfBoard, to: .outsideOfBoard, player: .none)
}
