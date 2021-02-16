//
//  OthelloGame.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import Foundation

class OthelloVM: ObservableObject {
    @Published private var othello: Othello
    
    init() {
        othello = Othello()
    }
    
    var currentState: Othello.State {
        othello.state
    }
}
