//
//  OthelloMovesChecker.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

/// Checks if the user can move in the Othello game
struct OthelloMovementChecker: MovementChecker {
    typealias State = Othello.State
    
    func checkIfUserCanMove(from position: Position, to direction: Movement.Direction, state: State) -> Movement? {
        if let modifier = chooseModifier(direction: direction) {
            var value: Int
            switch modifier.attribute {
            case .column:
                value = position.col
                break
            case .row:
                value = position.row
                break
            }
            modifier.modifier(&value)
            var foundOneCpuPlace = false
            while !modifier.stopCondition(value) {
                let currentPos: Position
                switch modifier.attribute {
                case .column:
                    currentPos = state[position.row][value]
                    break
                case .row:
                    currentPos = state[value][position.col]
                    break
                }
                let player = currentPos.player
                if player == .cpu {
                    foundOneCpuPlace = true
                }
                if player == .none {
                    // if the place is empty
                    if foundOneCpuPlace {
                        return Movement(
                            from: position,
                            to: currentPos,
                            direction: .right
                        )
                    }
                }
                if player == .user {
                    return nil
                }
                modifier.modifier(&value)
            }
        }
        return nil
    }
    
    
    /// Chooses the correct modifier
    /// - Parameter direction: movement direction
    /// - Returns: The correct modifier.
    private func chooseModifier(direction: Movement.Direction) -> AttributeModifier? {
        switch direction {
        case .top:
            return AttributeModifier(
                attribute: .row,
                modifier: { value in
                    value -= 1
                },
                stopCondition: { value in
                    value == 0
                }
            )
        case .right:
            return AttributeModifier(
                attribute: .column,
                modifier: { value in
                    value += 1
                },
                stopCondition: { value in
                    value == 8
                }
            )
        case .bottom:
            return AttributeModifier(
                attribute: .row,
                modifier: { value in
                    value += 1
                },
                stopCondition: { value in
                    value == 8
                }
            )
        case .left:
            return AttributeModifier(
                attribute: .column,
                modifier: { value in
                    value -= 1
                },
                stopCondition: { value in
                    value == 0
                }
            )
        default:
            return nil
        }
    }
}


struct AttributeModifier {
    var attribute: Attribute
    var modifier: (inout Int) -> Void
    var stopCondition: (Int) -> Bool
}


enum Attribute {
    case column
    case row
}
