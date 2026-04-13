//
//  BarraDeProgresso.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct BarraDeProgresso: View {
    
    let numeroExercicios: Int
    let exercicioAtual: Int

    var body: some View {
        HStack {
            ForEach(1...numeroExercicios, id: \.self) { i in
                RoundedRectangle(cornerRadius: 20)
                    .fill(i <= exercicioAtual ? Color("AccentColor") : Color("LightGray"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("AccentColor"), lineWidth: (i == exercicioAtual ? 3 : 0))
                    )
                    .frame(width: 40, height: 15)
                    .padding(2)
            }
        }
    }
}

#Preview {
    BarraDeProgresso(numeroExercicios: 5, exercicioAtual: 1)
}
