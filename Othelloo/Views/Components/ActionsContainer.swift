//
//  ActionsContainer.swift
//  Othelloo
//
//  Created by juandahurt on 20/02/21.
//

import SwiftUI

struct ActionsContainer: View {
    var newGameOnTap: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Black"))
            HStack {
                Spacer()
                VStack {
                    Image("New Game")
                    Text("New Game")
                }
                .onTapGesture {
                    newGameOnTap()
                }
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    VStack {
                        Image("Settings")
                        Text("Settings")
                    }
                }
                Spacer()
            }
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(Color("White").opacity(0.5))
        }
    }
}
