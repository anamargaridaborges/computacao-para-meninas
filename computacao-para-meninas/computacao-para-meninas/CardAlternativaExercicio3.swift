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

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("LightestGray"))
                .stroke(Color("Gray"), lineWidth: 4)
                .frame(width: 150, height: 130)
            Text(exercicios[idExercicio].alternativas[idx])
                .frame(width: 120)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }

}

#Preview {
    
}
