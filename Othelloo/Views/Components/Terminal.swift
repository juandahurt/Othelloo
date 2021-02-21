//
//  Terminal.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Terminal: View {
    var log: Log
    @State private var isPresented = true
    @Namespace private var animation
    
    var logsContainer: some View {
        VStack(spacing: 5) {
            Text("Terminal")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .padding(.bottom, 5)
            ForEach(log.logs, id: \.self) { text in
                HStack {
                    Text(text)
                    Spacer(minLength: 0)
                }
            }
            Spacer()
        }
        .foregroundColor(logsColor)
        .font(.system(size: 10, weight: .regular, design: .monospaced))
        .padding(10)
    }
    
    var terminalButton: some View {
        Image("Left-Arrow")
            .rotationEffect(.degrees(!isPresented ? 180 : 0))
            .onTapGesture {
                withAnimation(Animation.spring()) {
                    isPresented.toggle()
            }
        }
    }
    
    @ViewBuilder var body: some View {
        if isPresented {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(backgroundColor)
                    logsContainer
                    HStack {
                        Spacer(minLength: 0)
                        terminalButton
                    }.padding(.trailing, 5)
                }
            }
            .matchedGeometryEffect(id: "terminal", in: animation)
            .frame(width: presentedWidth, height: 135)
        } else {
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(backgroundColor)
                    HStack {
                        Spacer(minLength: 0)
                        terminalButton
                    }.padding(.trailing, 5)
                }.frame(width: hiddenWidth, height: 135)
                .matchedGeometryEffect(id: "terminal", in: animation)
            }
            .frame(maxWidth: presentedWidth)
        }
    }
    
    let presentedWidth: CGFloat = UIScreen.main.bounds.width - 30
    let hiddenWidth: CGFloat = 40
    let backgroundColor = Color("Black")
    let logsColor = Color("White")
}
