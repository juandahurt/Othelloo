//
//  OthelloView.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct OthelloView: View {
    @StateObject var othelloVM: OthelloVM
    
    var background: some View {
        Rectangle()
            .fill(backgroundColor)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
    
    var body: some View {
        ZStack {
            background
            VStack {
                Board(state: othelloVM.currentState, possibleMovements: othelloVM.possibleMoves)
                Spacer()
                Terminal()
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            .aspectRatio(contentMode: .fit)
        }
    }
    
    let backgroundColor = Color("Green")
}

//struct OthelloView_Previews: PreviewProvider {
//    static var previews: some View {
//        OthelloView(
//    }
//}
