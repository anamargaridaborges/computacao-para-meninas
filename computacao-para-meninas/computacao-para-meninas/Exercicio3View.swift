//
//  Exercicio3View.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct Exercicio3View: View {
    
    let idExercicio: Int

    var body: some View {
        VStack {
            Text(exercicios[idExercicio].enunciado)
                .padding()
        }
    }

}

#Preview {
    Exercicio3View(idExercicio: 0)
}
