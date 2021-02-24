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
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                    Text("New Game")
                }
                .onTapGesture {
                    newGameOnTap()
                }
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    VStack {
                        Image("Settings")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                        Text("Settings")
                    }
                }
                Spacer()
            }
            .font(.system(size: UIScreen.main.bounds.height * 0.015, weight: .bold, design: .monospaced))
                .foregroundColor(Color("White").opacity(0.5))
        }
    }
}

struct ActionsContainerPreviews: PreviewProvider {
    static let othelloVM = OthelloVM()
    
    static var previews: some View {
        OthelloView(othelloVM: othelloVM)
            .previewDevice("iPhone 11 Pro Max")
    }
}
