//
//  MultiplaEscolhaView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct MultiplaEscolhaView: View {
    @State private var viewModel: MultiplaEscolhaViewModel
    
    @Environment(\.dismiss) var dismiss
    
    let resposta: Int
    let codigo: String

    init(
        viewModel: MultiplaEscolhaViewModel,
        resposta: Int,
        codigo: String
    ) {
        self.resposta = resposta
        self.codigo = codigo
        self.viewModel = viewModel
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
                    ForEach(0 ..< viewModel.exercicio.alternativas.count/2, id : \.self) { i in
                        Button (action: {
                            viewModel.selecionar(i)
                        }) {
                            CardAlternativaMultiplaEscolha(idx: i, idSelecionado: viewModel.idSelecionado, resposta: resposta, continuado: viewModel.estadoFeedback != .neutro, texto: viewModel.exercicio.alternativas[i])
                        }
                        .accessibilityIdentifier("card1_\(i)")
                    }
                }
                .padding(2)

                HStack {
                    ForEach(viewModel.exercicio.alternativas.count / 2..<viewModel.exercicio.alternativas.count, id : \.self) { i in
                        Button (action: {
                            viewModel.selecionar(i)
                        }) {
                            CardAlternativaMultiplaEscolha(idx: i, idSelecionado: viewModel.idSelecionado, resposta: resposta, continuado: viewModel.estadoFeedback != .neutro, texto: viewModel.exercicio.alternativas[i])
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
                            viewModel.onConcluirAtividade()
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

//#Preview {
//    MultiplaEscolhaView(
//        idAtividade: "atv_exemplo",
//        aoConcluirRodada: {},
//        idExercicio: 0,
//        numeroExercicios: 5,
//        exercicioAtual: 1,
//        resposta: 0,
//        codigo: "num1 = 5"
//    )
//}
