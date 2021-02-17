//
//  Move.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation


/// Represents an user movement.
struct Movement {
    /// Position where the move starts.
    var from: Position
    
    /// Positions where the move finishes.
    var to: Position
    
    /// Direction of the move
    var direction: Direction
    
    enum Direction {
        case top
        case right
        case bottom
        case left
        case upRight
        case upLeft
        case bottomRight
        case bottomLeft
        static let directions: [Direction] = [top, right, bottom, left]
    }
}
