//
//  Log.swift
//  Othelloo
//
//  Created by juandahurt on 17/02/21.
//

import Foundation

struct Log: Identifiable {
    var id: Int
    var message: String
    
    init(id: Int, message: LogMessage) {
        self.id = id
        self.message = "machine: " + message.text
    }
}
