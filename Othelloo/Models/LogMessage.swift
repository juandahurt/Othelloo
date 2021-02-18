//
//  FunnyMessage.swift
//  Othelloo
//
//  Created by juandahurt on 18/02/21.
//

import Foundation

/// Message that machine shows to the user. This is the way the machine communicates
/// whith the the user
struct LogMessage {
    var text: String
    
    enum MessageType {
        case afterUserMovement
        case afterCpuMovement
        case none
    }
    
    private static let messagesAfterUserMovement: [LogMessage] = [
        LogMessage(text: "That was a good one."),
        LogMessage(text: "Are you serious?"),
        LogMessage(text: "Hahaha"),
        LogMessage(text: "That's all you've got?"),
        LogMessage(text: "Hmm..."),
        LogMessage(text: "Just, let me think for a momment."),
        LogMessage(text: "Am I a joke to you?")
    ]
    
    private static let messagesAfterCpuMovement: [LogMessage] = [
        LogMessage(text: "Show me what you've got."),
        LogMessage(text: "Sorry, but I had to do it."),
        LogMessage(text: "You were not expecting that, hu?"),
        LogMessage(text: "It's your turn."),
        LogMessage(text: "I'm getting tired of you..."),
        LogMessage(text: "I know, but I had no choice.")
    ]
    
    static func random(type: MessageType) -> LogMessage? {
        switch type {
        case .afterUserMovement:
            return messagesAfterUserMovement.randomElement()!
        case .afterCpuMovement:
            return messagesAfterCpuMovement.randomElement()!
        case .none:
            return nil
        }
    }
}
