//
//  MultiplaEscolhaView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct MultiplaEscolhaView: View {
    @StateObject private var viewModel: MultiplaEscolhaViewModel
    @Environment(\.dismiss) var dismiss
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int
    let resposta: Int
    let codigo: String

    init(
        idAtividade: String,
        aoConcluirRodada: @escaping () -> Void,
        idExercicio: Int,
        numeroExercicios: Int,
        exercicioAtual: Int,
        resposta: Int,
        codigo: String
    ) {
        self.idAtividade = idAtividade
        self.aoConcluirRodada = aoConcluirRodada
        self.idExercicio = idExercicio
        self.numeroExercicios = numeroExercicios
        self.exercicioAtual = exercicioAtual
        self.resposta = resposta
        self.codigo = codigo
        _viewModel = StateObject(wrappedValue: MultiplaEscolhaViewModel(
            idExercicio: idExercicio,
            resposta: resposta,
            codigo: codigo
        ))
    }

    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("DarkGray"))
                        .frame(width: 350, height: 200)
                    Text(codigo)
                        .foregroundStyle(Color.white)
                        .frame(width: 300)
                        .multilineTextAlignment(.leading)
                        .monospaced()
                }

                HStack {
                    ForEach(0..<exercicios[idExercicio].alternativas.count/2, id : \.self) { i in
                        Button (action: {
                            viewModel.selecionar(i)
                        }) {
                            CardAlternativaMultiplaEscolha(idx: i, idExercicio: idExercicio, idSelecionado: viewModel.idSelecionado, resposta: resposta, continuado: viewModel.estadoFeedback != .neutro)
                        }
                        .accessibilityIdentifier("card1_\(i)")
                    }
                }
                .padding(2)

                HStack {
                    ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                        Button (action: {
                            viewModel.selecionar(i)
                        }) {
                            CardAlternativaMultiplaEscolha(idx: i, idExercicio: idExercicio, idSelecionado: viewModel.idSelecionado, resposta: resposta, continuado: viewModel.estadoFeedback != .neutro)
                        }
                        .accessibilityIdentifier("card1_\(i)")
                    }
                }
                .padding(2)


                Spacer()

                if viewModel.estadoFeedback == .neutro {
                    Button(action: {
                        viewModel.verificar()
                    }) {
                        BotaoContinuar(continuarDesativado: !viewModel.botaoAtivo)
                    }
                    .padding()
                    .disabled(!viewModel.botaoAtivo)
                }
            }
            .navigationBarBackButtonHidden()
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
                        withAnimation { viewModel.resetar() }
                    }
                )
                .ignoresSafeArea(edges: .bottom)
                .transition(.move(edge: .bottom))
                .frame(maxHeight: (viewModel.estadoFeedback == .acerto ? 80 : .infinity))
            }
        }
        .animation(.spring(response: 0.35), value: viewModel.estadoFeedback)
    }

}

#Preview {
    MultiplaEscolhaView(
        idAtividade: "atv_exemplo",
        aoConcluirRodada: {},
        idExercicio: 0,
        numeroExercicios: 5,
        exercicioAtual: 1,
        resposta: 0,
        codigo: "num1 = 5"
    )
}
