//
//  CardAlternativaExercicio3.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct CardAlternativaExercicio1: View {
    
    let idx: Int
    let idExercicio: Int
    let selecionado: Bool
    let resposta: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("LightestGray"))
                .stroke(Color("Gray"), lineWidth: 2)
                .frame(width: 80, height: 60)
            Text(exercicios[idExercicio].alternativas[idx])
                .foregroundStyle(Color.black)
                .frame(width: 60)
                .multilineTextAlignment(.leading)
                .monospaced()
        }
        .padding()
    }
    
//    private func strokeColor() -> Color {
//        if (desativado) {
//            return Color("DarkGreen")
//        }
//        else if (erro == idx) {
//            return Color("Wrong")
//        }
//        else if (selecionado == idx) {
//            return Color("AccentColor")
//        }
//        return Color("Gray")
//    }
}

#Preview {
    
}
