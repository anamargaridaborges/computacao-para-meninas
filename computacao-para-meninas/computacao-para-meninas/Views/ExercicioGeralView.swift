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
    @State private var rodadaAtual: Int = 0

    let totalDeRodadas: Int
    @State var estadoFeedback: EstadoFeedback = .neutro
    let mensagemErro: String = "Para realizar uma soma com num1, preciso que essa variável armazene um inteiro."
    @State var idSelecionado: Int = -1
    
    @Environment(\.dismiss) var dismiss
    
    
    init(viewModel: TrilhaViewModel, idx: Int, idAtividade: String, rodadaAtual: Int=0) {
        self.viewModel = viewModel
        self.idx = idx
        self.idAtividade = idAtividade
        self.rodadaAtual = rodadaAtual
        
        self.totalDeRodadas = exercicios.count
    }
    
    var body: some View {
            VStack {
                // aqui vai resetando os cards a cada licao
                switch exercicios[rodadaAtual].tipo {
                case .tipo3(let primeiro, let segundo):
                    Exercicio3View(
                        viewModel: viewModel,
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        vetor1: primeiro,
                        vetor2: segundo,
                        desativado: Array(repeating: false, count: exercicios[idx].alternativas.count)
                    )
                    .id(rodadaAtual)
                    
                case .tipo1(let resposta, let codigo):
                    Exercicio1View(
                        viewModel: viewModel,
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        resposta: resposta,
                        codigo: codigo,
                        idSelecionado: $idSelecionado,
                        estadoFeedback: $estadoFeedback
                    )
                    .id(rodadaAtual)
                }
                Spacer()
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
                        BarraDeProgresso(numeroExercicios: totalDeRodadas, exercicioAtual: rodadaAtual+1)
                            .animation(.spring(response: 1.0, dampingFraction: 0.7), value: rodadaAtual)
                        Spacer()
                        Button (action: {}) {
                            Image("Doubt")
                        }
                        .padding()
                    }
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if estadoFeedback != .neutro, case .tipo1 = exercicios[rodadaAtual].tipo {
                    BarraFeedback(
                        mensagem: mensagemErro,
                        estado: estadoFeedback,
                        aoTocar: {
                            if estadoFeedback == .acerto {
                                proximaEtapa()
                            }
                            withAnimation { estadoFeedback = .neutro
                            idSelecionado = -1 }
                        }
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .transition(.move(edge: .bottom))
                    .frame(maxHeight: (estadoFeedback == .acerto ? 80 : .infinity))
                }
            }
            .animation(.spring(response: 0.35), value: estadoFeedback)
        
    }
    
    func proximaEtapa() {
        if rodadaAtual < totalDeRodadas - 1 {
            rodadaAtual += 1
        } else {
            viewModel.concluirAtividade(id: idAtividade)
            dismiss()
        }
    }
}
#Preview {
    ExercicioGeralView(viewModel: TrilhaViewModel(), idx: 0, idAtividade: "atv_1")}
