//
//  UserSettings.swift
//  Othelloo
//
//  Created by juandahurt on 22/02/21.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var difficulty: Othello.Difficulty = .medium
}
