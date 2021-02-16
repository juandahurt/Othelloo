//
//  Terminal.swift
//  Othelloo
//
//  Created by juandahurt on 16/02/21.
//

import SwiftUI

struct Terminal: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(backgroundColor)
            .frame(width: UIScreen.main.bounds.width - 30, height: 150)
    }
    
    let backgroundColor = Color("Black")
}

struct Terminal_Previews: PreviewProvider {
    static var previews: some View {
        Terminal()
    }
}
