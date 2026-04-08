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
                .fill((desativado ? Color("Gray") : Color("LightestGray")))
                .stroke((erro == idx ? Color("Wrong") : (selecionado == idx ? Color("AccentColor") : Color("Gray"))), lineWidth: (desativado ? 0 : selecionado == idx ? 8 : 4))
                .frame(width: 150, height: 130)
            Text(exercicios[idExercicio].alternativas[idx])
                .foregroundStyle((desativado ? Color.white : Color.black))
                .frame(width: 120)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }

}

#Preview {
    
}
