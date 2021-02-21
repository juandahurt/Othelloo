//
//  SettingsView.swift
//  Othelloo
//
//  Created by juandahurt on 20/02/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var difficulty: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Black"))
            VStack {
                Text("Difficulty")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .padding(.bottom, 10)
                HStack {
                    Text("Easy")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .underline(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, color: Color("White"))
                    Spacer()
                    Text("Normal")
                        .font(.system(size: 18, weight: .regular, design: .monospaced))
                    Spacer()
                    Text("Hard")
                        .font(.system(size: 18, weight: .regular, design: .monospaced))
                }
            }.padding()
        }.frame(height: 60)
    }
    
    func miniBoard(userIsAt userPosition: Position, cpuIsAt cpuPosition: Position, possiblePosition: Position) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth / 12
        return Group {
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { col in
                            ZStack {
                                Rectangle()
                                    .fill((row + col) % 2 == 0 ? brownColor : brownLightColor)
                                    .frame(width: cellWidth, height: cellWidth)
                                Circle()
                                    .fill(getCorrectColor(at: Position(row: row, col: col, player: .none), userPosition: userPosition, cpuPosition: cpuPosition))
                                    .frame(width: cellWidth * 0.8, height: cellWidth * 0.8)
                                Circle()
                                    .fill(row == possiblePosition.row && col == possiblePosition.col ? userColor.opacity(0.3) : .clear)
                                    .frame(width: cellWidth * 0.2, height: cellWidth * 0.2)
                            }
                        }
                    }
                }
            }
        }.cornerRadius(5)
    }
    
    private func getCorrectColor(at position: Position, userPosition: Position, cpuPosition: Position) -> Color {
        position == userPosition ? userColor : position == cpuPosition ? cpuColor : .clear
    }
    
    var rules: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Black"))
            VStack {
                Text("Rules")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .padding(.bottom)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        horizontalRule
                        verticalRule
                        diagonalRule
                    }
                }
            }.padding()
        }.aspectRatio(contentMode: .fit)
    }
    
    var horizontalRule: some View {
        VStack {
            miniBoard(
                userIsAt: Position(row: 1, col: 0, player: .none),
                cpuIsAt: Position(row: 1, col: 1, player: .none),
                possiblePosition: Position(row: 1, col: 2, player: .none)
            )
            Text("Horizontal")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            HStack {
                Text("Yes")
                    .underline()
                Text("No")
            }.font(.system(size: 12, weight: .regular, design: .monospaced))
        }
    }
    
    var verticalRule: some View {
        VStack {
            miniBoard(
                userIsAt: Position(row: 2, col: 1, player: .none),
                cpuIsAt: Position(row: 1, col: 1, player: .none),
                possiblePosition: Position(row: 0, col: 1, player: .none)
            )
            Text("Vertical")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            HStack {
                Text("Yes")
                    .underline()
                Text("No")
            }.font(.system(size: 12, weight: .regular, design: .monospaced))
        }
    }
    
    var diagonalRule: some View {
        VStack {
            miniBoard(
                userIsAt: Position(row: 2, col: 0, player: .none),
                cpuIsAt: Position(row: 1, col: 1, player: .none),
                possiblePosition: Position(row: 0, col: 2, player: .none)
            )
            Text("Diagonal")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            HStack {
                Text("Yes")
                    .underline()
                Text("No")
            }.font(.system(size: 12, weight: .regular, design: .monospaced))
        }
    }
    
    var closeButton: some View {
        Image("Close")
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    closeButton
                    Spacer()
                }
                .padding(.top, 40)
                difficulty
                    .padding(.vertical, 40)
                rules
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("White"))
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background)
        .ignoresSafeArea()
    }
    
    private let userColor = Color("Black")
    private let cpuColor = Color("White")
    private let background = Color("Green")
    private let brownColor = Color("Brown")
    private let brownLightColor = Color("Brown-Light")
}
