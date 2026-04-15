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
    @State private var idxx: Int = 0
    let totalDeRodadas: Int = 5
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack {
                // aqui vai resetando os cards a cada licao
                switch exercicios[idxx].tipo {
                case .tipo3(let primeiro, let segundo):
                    Exercicio3View(
                        viewModel: viewModel,
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: idxx,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        vetor1: primeiro,
                        vetor2: segundo,
                        desativado: Array(repeating: false, count: exercicios[idx].alternativas.count)
                    )
                    .id(rodadaAtual)
                    
                case .tipo1(let primeiro, let segundo):
                    Exercicio1View(
                        viewModel: viewModel,
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: idxx,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        resposta: primeiro,
                        codigo: segundo,
                    )
                    .id(rodadaAtual)
                }
                
            }
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        // se clicar em voltar, sai de tudo e volta para a home
                        Button (action: { dismiss() }) {
                            Image("ActivityBack")
                        }
                        .padding()
                        Spacer()
                        BarraDeProgresso(numeroExercicios: totalDeRodadas, exercicioAtual: rodadaAtual)
                            .animation(.spring(response: 1.0, dampingFraction: 0.7), value: rodadaAtual)
                        Spacer()
                        Button (action: {}) {
                            Image("Doubt")
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        
    }
    
    func proximaEtapa() {
        if rodadaAtual < totalDeRodadas {
            rodadaAtual += 1
        } else {
            viewModel.concluirAtividade(id: idAtividade)
            dismiss()
        }
        
        idxx = (idxx + 1) % 2
    }
}
#Preview {
    ExercicioGeralView(viewModel: TrilhaViewModel(), idx: 0, idAtividade: "atv_1")}
