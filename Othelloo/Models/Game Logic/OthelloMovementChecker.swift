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
    
    func checkIfPlayerCanMove(from position: Position, to direction: Movement.Direction, player: Player, state: State) -> Movement? {
        if let modifier = ValueModifier.chooseModifier(direction: direction) {
            var value: Int
            var secondValue: Int?
            switch modifier.valueType {
            case .column:
                value = position.col
                break
            case .row:
                value = position.row
                break
            case .both:
                value = position.row
                secondValue = position.col
                break
            }
            modifier.modifier(&value,&secondValue)
            var foundOponent = false
            let oponent: Player
            if player == .cpu { oponent = .user }
            else { oponent = .cpu }
            while !modifier.stopCondition(value,secondValue) {
                let currentPos: Position
                switch modifier.valueType {
                case .column:
                    currentPos = state[position.row][value]
                    break
                case .row:
                    currentPos = state[value][position.col]
                    break
                case .both:
                    currentPos = state[value][secondValue!]
                    break
                }
                let currentPlayer = currentPos.player
                if currentPlayer == oponent {
                    foundOponent = true
                }
                if currentPlayer == .none {
                    // if the place is empty
                    if foundOponent {
                        return Movement(
                            from: position,
                            to: currentPos,
                            direction: direction
                        )
                    } else {
                        return nil
                    }
                }
                if currentPlayer == player {
                    return nil
                }
                modifier.modifier(&value,&secondValue)
            }
        }
        return nil
    }
}
