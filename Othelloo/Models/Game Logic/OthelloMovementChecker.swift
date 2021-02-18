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
            switch modifier.valueType {
            case .column:
                value = position.col
                break
            case .row:
                value = position.row
                break
            }
            modifier.modifier(&value)
            var foundOponent = false
            let oponent: Player
            if player == .cpu { oponent = .user }
            else { oponent = .cpu }
            while !modifier.stopCondition(value) {
                let currentPos: Position
                switch modifier.valueType {
                case .column:
                    currentPos = state[position.row][value]
                    break
                case .row:
                    currentPos = state[value][position.col]
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
                    }
                }
                if currentPlayer == player {
                    return nil
                }
                modifier.modifier(&value)
            }
        }
        return nil
    }
}
