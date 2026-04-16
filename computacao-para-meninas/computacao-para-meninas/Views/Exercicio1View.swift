//
//  Exercicio1View.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct Exercicio1View: View {
    @ObservedObject var viewModel: TrilhaViewModel
    @Environment(\.dismiss) var dismiss
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int
    let resposta: Int
    let codigo: String
    @State var botaoAtivo: Bool = false
    @Binding var idSelecionado: Int
    @State var continuado: Bool = false
    @Binding var estadoFeedback: EstadoFeedback
    let mensagemErro: String = "Para realizar uma soma com num1, preciso que essa variável armazene um inteiro."

    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                HStack {
                    Text(exercicios[idExercicio].enunciado)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding()
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
                            botaoAtivo = true
                            idSelecionado = i
                        }) {
                            CardAlternativaExercicio1(idx: i, idExercicio: idExercicio, idSelecionado: idSelecionado, resposta: resposta, continuado: continuado)
                        }
                        .accessibilityIdentifier("card1_\(i)")
                    }
                }
                .padding(2)
                
                HStack {
                    ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                        Button (action: {
                            botaoAtivo = true
                            idSelecionado = i
                        }) {
                            CardAlternativaExercicio1(idx: i, idExercicio: idExercicio, idSelecionado: idSelecionado, resposta: resposta, continuado: continuado)
                        }
                        .accessibilityIdentifier("card1_\(i)")
                    }
                }
                .padding(2)
                
                
                Spacer()
                
                if estadoFeedback == .neutro {
                    Button(action: {
                        if (idSelecionado == resposta) {
                            estadoFeedback = .acerto
                        }
                        else {
                            estadoFeedback = .erro
                        }
                    }) {
                        BotaoContinuar(continuarDesativado: !botaoAtivo)
                    }
                    .padding()
                    .disabled(!botaoAtivo)
                }
            }
            .navigationBarBackButtonHidden()
        }
//            .safeAreaInset(edge: .bottom, spacing: 0) {
//                if estadoFeedback != .neutro {
//                    BarraFeedback(
//                        mensagem: mensagemErro,
//                        estado: estadoFeedback,
//                        aoTocar: {
//                            if estadoFeedback == .acerto {
//                                aoConcluirRodada()
//                            }
//                            withAnimation { estadoFeedback = .neutro
//                            idSelecionado = -1 }
//                        }
//                    )
//                    .ignoresSafeArea(edges: .bottom)
//                    .transition(.move(edge: .bottom))
//                }
//            }
//            .animation(.spring(response: 0.35), value: estadoFeedback)
    }

}

#Preview {
    
}
