//
//  Terminal.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Terminal: View {
    var logs: [Log]
    @State private var isPresented = true
    @Namespace private var animation
    
    var logsContainer: some View {
        VStack(spacing: 5) {
            Text("Terminal")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .padding(.bottom, 5)
            ForEach(logs) { log in
                HStack {
                    Text(log.message)
                    Spacer(minLength: 0)
                }
            }
            Spacer()
        }
        .foregroundColor(logsColor)
        .font(.system(size: 10, weight: .regular, design: .monospaced))
        .padding(10)
    }
    
    @ViewBuilder var body: some View {
        if isPresented {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(backgroundColor)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 135)
                    .matchedGeometryEffect(id: "terminal", in: animation)
                logsContainer
                    .frame(width: UIScreen.main.bounds.width - 30, height: 135)
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    isPresented.toggle()
                }
            }
        } else {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(backgroundColor)
                            .matchedGeometryEffect(id: "terminal", in: animation)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isPresented.toggle()
                                }
                            }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: 135)
        }
    }
    
    let backgroundColor = Color("Black")
    let logsColor = Color("White")
}
