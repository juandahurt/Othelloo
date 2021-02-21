//
//  ActionsContainer.swift
//  Othelloo
//
//  Created by juandahurt on 20/02/21.
//

import SwiftUI

struct ActionsContainer: View {
    var newGameOnTap: () -> Void
    @State private var isPresented = true
    @Namespace private var animation
    
    var button: some View {
        Image("Left-Arrow")
            .resizable()
            .rotationEffect(.degrees(!isPresented ? 180 : 0))
            .frame(width: 20, height: 20)
            .padding()
            .onTapGesture {
                withAnimation(.spring()) {
                    isPresented.toggle()
                }
            }
    }
    
    @ViewBuilder var body: some View {
        if isPresented {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("Black"))
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("Black-Dark"))
                    .padding(5)
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
                VStack {
                    HStack {
                        Spacer()
                        button
                    }
                    Spacer()
                }
            }.matchedGeometryEffect(id: "Container", in: animation)
        } else {
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("Black"))
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("Black-Dark"))
                        .padding(5)
                    VStack {
                        button
                        Spacer()
                    }
                }
                .matchedGeometryEffect(id: "Container", in: animation)
                .frame(width: 40)
            }.padding(.trailing, 5)
        }
    }
}
