//
//  OthelloMovementExcecutor.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

/// Movement excecutor in Othello game
struct OthelloMovementExcecutor: MovementExcecutor {
    typealias State = Othello.State
    
    func excecute(movement: Movement, by player: Player, in state: Othello.State) -> Othello.State {
        if let modifier = EdgeModifier.chooseModifier(direction: movement.direction) {
            var value: Int
            let limit: Int
            var secondValue: Int?
            var secondLimit: Int?
            switch modifier.edge {
            case .vertical:
                value = movement.from.col
                limit = movement.to.col
                break
            case .horizontal:
                value = movement.from.row
                limit = movement.to.row
                break
            case .all:
                value = movement.from.row
                limit = movement.to.row
                secondValue = movement.from.col
                secondLimit = movement.to.col
                break
            }
            modifier.modifier(&value, &secondValue)
            var stateCopy = state
            var lastSpaceWasModified = false
            while !modifier.stopCondition(value, secondValue) && !lastSpaceWasModified {
                switch modifier.edge {
                case .vertical:
                    stateCopy[movement.from.row][value].player = player
                    break
                case .horizontal:
                    stateCopy[value][movement.from.col].player = player
                    break
                case .all:
                    stateCopy[value][secondValue!].player = player
                }
                if limit == value && secondLimit == secondValue {
                    lastSpaceWasModified = true
                }
                modifier.modifier(&value, &secondValue)
            }
            return stateCopy
        } else {
            return state
        }
    }
}
