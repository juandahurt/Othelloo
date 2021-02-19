//
//  NoMovements.swift
//  Othelloo
//
//  Created by juandahurt on 19/02/21.
//

import SwiftUI

struct NoMovements: View {
    var onTap: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Black"))
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Black-Dark"))
                .padding(5)
            VStack(spacing: 15) {
                Text("You don't have any possible moves.")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Text("Tap here to pass your turn.")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
            }
            .onTapGesture {
                onTap()
            }
            .transition(.slide)
            .animation(.linear)
                .foregroundColor(Color("White"))
        }.frame(width: UIScreen.main.bounds.width - 30, height: 120)
    }
}
