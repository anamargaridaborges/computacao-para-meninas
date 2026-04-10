//
//  BotaoContinuar.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct BotaoContinuar: View {
    
    let continuarDesativado: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill((continuarDesativado ? Color("Gray") : Color("AccentColor")))
                .frame(width: 350, height: 50)
            Text("Continuar")
                .foregroundStyle(Color.white)
                .bold()
        }
        .accessibilityIdentifier("Continuar")
    }
}

#Preview {
    
}
