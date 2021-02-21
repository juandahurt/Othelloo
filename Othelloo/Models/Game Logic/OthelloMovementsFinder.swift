//
//  OthelloMovementsFinder.swift
//  Othelloo
//
//  Created by juandahurt on 21/02/21.
//

import Foundation

struct OthelloMovementsFinder: MovementsFinder {
    static func checkIfPlayerCanMove(from position: Position, to direction: Movement.Direction, player: Player, state: [[Position]]) -> Movement? {
        if let modifier = EdgeModifier.chooseModifier(direction: direction) {
            var value: Int
            var secondValue: Int?
            switch modifier.edge {
            case .vertical:
                value = position.col
                break
            case .horizontal:
                value = position.row
                break
            case .all:
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
                switch modifier.edge {
                case .vertical:
                    currentPos = state[position.row][value]
                    break
                case .horizontal:
                    currentPos = state[value][position.col]
                    break
                case .all:
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
    
    static func findMovements(for player: Player, directions: [Movement.Direction], in state: Othello.State) -> [Movement] {
        var playerPositions: [Position] = []
        var movements: [Movement] = []
        for row in 0..<8 {
            for col in 0..<8 {
                let position = state[row][col]
                if position.player == player { playerPositions.append(position) }
            }
        }
        for position in playerPositions {
            for direction in Movement.Direction.directions {
                if let movement = Self.checkIfPlayerCanMove(from: position, to: direction, player: player, state: state) {
                    movements.append(movement)
                }
            }
        }
        return movements
    }
}
