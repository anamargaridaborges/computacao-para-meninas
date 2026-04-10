//
//  CardAlternativaExercicio3.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct CardAlternativaExercicio3: View {
    
    let idx: Int
    let idExercicio: Int
    let selecionado: Int
    let erro: Int
    let desativado: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill((desativado ? Color("LightGreen") : Color("LightestGray")))
                .stroke(strokeColor(), lineWidth: (desativado ? 4 : selecionado == idx ? 8 : 4))
                .frame(width: 150, height: 130)
            Text(exercicios[idExercicio].alternativas[idx])
                .foregroundStyle((desativado ? Color("DarkGreen") : Color.black))
                .frame(width: 120)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
    
    private func strokeColor() -> Color {
        if (desativado) {
            return Color("DarkGreen")
        }
        else if (erro == idx) {
            return Color("Wrong")
        }
        else if (selecionado == idx) {
            return Color("AccentColor")
        }
        return Color("Gray")
    }

}

#Preview {
    
}
