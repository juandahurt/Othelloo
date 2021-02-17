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
    static let test = Position(row: 0, col: 0, player: .none)
}
