//
//  RelacionarColunasView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct RelacionarColunasView: View {
    @StateObject private var viewModel: RelacionarColunasViewModel
    @Environment(\.dismiss) var dismiss
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int

    init(
        idAtividade: String,
        aoConcluirRodada: @escaping () -> Void,
        idExercicio: Int,
        numeroExercicios: Int,
        exercicioAtual: Int,
        vetor1: [Int],
        vetor2: [Int]
    ) {
        self.idAtividade = idAtividade
        self.aoConcluirRodada = aoConcluirRodada
        self.idExercicio = idExercicio
        self.numeroExercicios = numeroExercicios
        self.exercicioAtual = exercicioAtual
        _viewModel = StateObject(wrappedValue: RelacionarColunasViewModel(
            idExercicio: idExercicio,
            vetor1: vetor1,
            vetor2: vetor2
        ))
    }

    var body: some View {
            VStack {
                HStack {
                    VStack {
                        ForEach(0..<exercicios[idExercicio].alternativas.count / 2, id : \.self) { i in
                            Button (action: {
                                viewModel.selecionarColuna1(i)
                            }) {
                                CardAlternativaRelacionarColunas(idx: i, idExercicio: idExercicio, selecionado: viewModel.selecionado1, erro: viewModel.erro1, desativado: viewModel.desativado[i])
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(viewModel.desativado[i])
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                            Button (action: {
                                viewModel.selecionarColuna2(i)
                            }) {
                                CardAlternativaRelacionarColunas(idx: i, idExercicio: idExercicio, selecionado: viewModel.selecionado2, erro: viewModel.erro2, desativado: viewModel.desativado[i])
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(viewModel.desativado[i])
                        }
                    }
                    .padding(5)
                }

                Spacer()
            }
            .navigationBarBackButtonHidden()
            .task(id: viewModel.selecionado1) {
                await viewModel.checkAcerto()
            }
            .task(id: viewModel.selecionado2) {
                await viewModel.checkAcerto()
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if viewModel.estadoFeedback != .neutro {
                    BarraFeedback(
                        mensagem: viewModel.mensagemErro,
                        estado: viewModel.estadoFeedback,
                        aoTocar: {
                            if viewModel.estadoFeedback == .acerto {
                                aoConcluirRodada()
                            }
                            withAnimation { viewModel.estadoFeedback = .neutro }
                        }
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring(response: 0.35), value: viewModel.estadoFeedback)
    }

}

#Preview {
    RelacionarColunasView(
        idAtividade: "atv_exemplo",
        aoConcluirRodada: {},
        idExercicio: 0,
        numeroExercicios: 5,
        exercicioAtual: 1,
        vetor1: [0, 1, 2],
        vetor2: [3, 4, 5]
    )
}
