//
//  OthelloCpuMovementTest.swift
//  OthellooTests
//
//  Created by juandahurt on 23/02/21.
//

@testable import Othelloo
import XCTest

class OthelloCpuMovementTest: XCTestCase {
    var game: Othello!
    
    override func setUp() {
        game = Othello()
    }
    
    override func tearDown() {
        game = nil
    }
    
    func test_if_cpu_moves_using_alpha_beta() {
        // initialState (U -> user, C -> cpu):
        // C C C C C C C C
        // C C C C C C C C
        // C C C C C C C C
        // C C C C C C C C
        // C C C C C C C C
        // C C C C C C C C
        // P C C C C C C C
        //   C C C C C C C
        var initialState: Othello.State = []
        for row in 0..<8 {
            var rowAux: [Position] = []
            for col in 0..<8 {
                rowAux.append(Position(row: row, col: col, player: .cpu))
            }
            initialState.append(rowAux)
        }
        initialState[6][0].player = .user
        initialState[7][0].player = .none
        game.state = initialState
        game.cpuTurn(difficulty: .hard)
        XCTAssert(initialState != game.state)
    }
}
