//
//  Log.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

struct Log {
    var logs: [String] = []
    
    init() {
        add("Welcome.", isFromTheMachine: false)
        add("Those little circles represent the places where you can move.", isFromTheMachine: false)
        add("Waiting for user to move...", isFromTheMachine: false)
    }
    
    mutating func add(_ message: String, isFromTheMachine: Bool = true) {
        let text = (isFromTheMachine ? "machine: " : "server: ") + message
        logs.append(text)
        if logs.count > 4 { logs.remove(at: 0) }
    }
}
