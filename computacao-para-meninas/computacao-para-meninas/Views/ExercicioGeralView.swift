//
//  ExercicioGeralView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct ExercicioGeralView: View {
    @ObservedObject var viewModel: TrilhaViewModel
    var idx: Int
    let idAtividade: String
    @State private var rodadaAtual: Int = 1
    let totalDeRodadas: Int = 5
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            // aqui vai resetando os cards a cada licao
            switch exercicios[idx].tipo {
            case .tipo3(let primeiro, let segundo):
                Exercicio3View(
                    viewModel: viewModel,
                    idAtividade: idAtividade,
                    aoConcluirRodada: {
                        proximaEtapa()
                    },
                    idExercicio: idx,
                    numeroExercicios: totalDeRodadas,
                    exercicioAtual: rodadaAtual,
                    vetor1: primeiro,
                    vetor2: segundo,
                    desativado: Array(repeating: false, count: exercicios[idx].alternativas.count)
                )
                .id(rodadaAtual)
            }
        }
    }
    
    func proximaEtapa() {
        if rodadaAtual < totalDeRodadas {
            withAnimation {
                rodadaAtual += 1
            }
        } else {
            viewModel.concluirAtividade(id: idAtividade)
            dismiss()
        }
    }
}
#Preview {
    ExercicioGeralView(viewModel: TrilhaViewModel(), idx: 0, idAtividade: "atv_1")}
