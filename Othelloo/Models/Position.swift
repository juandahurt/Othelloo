//
//  Position.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

struct Position {
    var row: Int
    var col: Int
    var player: Player
}


extension Position {
    static let outsideOfBoard = Position(row: -1, col: -1, player: .none)
}
