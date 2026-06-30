//
//  CardAlternativaMultiplaEscolha.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct CardAlternativaMultiplaEscolha: View {
    let idx: Int
    let idSelecionado: Int
    let resposta: Int
    let continuado: Bool
    let texto: String

    private var acertouEsta: Bool {
        continuado && idSelecionado == idx && resposta == idx
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(acertouEsta ? Color("LightGreen") : Color("LightestGray"))
                .stroke(strokeColor(), lineWidth: (idSelecionado == idx ? 4 : 2))
                .frame(width: 80, height: 60)
            Text(texto)
                .foregroundStyle(acertouEsta ? Color("DarkGreen") : Color.black)
                .frame(width: 60)
                .multilineTextAlignment(.leading)
                .monospaced()
        }
        .padding()
    }

    private func strokeColor() -> Color {
        
        if (idSelecionado != idx) {
            return Color("Gray")
        }
        
        if (continuado) {
            if (resposta == idx) {
                return Color("DarkGreen")
            }
            
            return Color("Wrong")
        }
        
        return Color("AccentColor")
    }
}

#Preview {
    
}
