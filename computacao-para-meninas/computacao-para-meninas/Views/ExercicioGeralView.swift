//
//  ExercicioGeralView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct ExercicioGeralView: View {
    
    var idx: Int

    var body: some View {
        VStack {
            switch exercicios[idx].tipo {
            case .tipo3(let primeiro, let segundo):
                Exercicio3View(idExercicio: idx, numeroExercicios: 5, exercicioAtual: 1, vetor1: primeiro, vetor2: segundo, desativado: Array(repeating: false, count: exercicios[idx].alternativas.count))
            }
        }
    }

}

#Preview {
    
}
