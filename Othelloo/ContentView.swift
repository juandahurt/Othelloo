//
//  ContentView.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OthelloView(othelloVM: OthelloVM())
            .environmentObject(UserSettings())
    }
}
