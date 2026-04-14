//
//  Exercicio3View.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct Exercicio3View: View {
    @ObservedObject var viewModel: TrilhaViewModel
    @Environment(\.dismiss) var dismiss
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int
    @State var selecionado1: Int = -1
    @State var selecionado2: Int = -1
    @State var erro1: Int = -1
    @State var erro2: Int = -1
    let vetor1: [Int]
    let vetor2: [Int]
    @State var desativado: [Bool]
    @State var continuarDesativado: Bool = true
    @State private var estadoFeedback: EstadoFeedback = .neutro
    @State private var mensagemErro: String = ""

    var body: some View {
            VStack {
                HStack {
                    // se clicar em voltar, sai de tudo e volta para a home
                    Button (action: { dismiss() }) {
                        Image("ActivityBack")
                    }
                    .padding()
                    Spacer()
                    BarraDeProgresso(numeroExercicios: numeroExercicios, exercicioAtual: exercicioAtual)
                    Spacer()
                    Button (action: {}) {
                        Image("Doubt")
                    }
                    .padding()
                }
                HStack {
                    Text(exercicios[idExercicio].enunciado)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                .padding()
                HStack {
                    VStack {
                        ForEach(0..<exercicios[idExercicio].alternativas.count / 2, id : \.self) { i in
                            Button (action: {
                                if desativado[i] {
                                    return
                                }
                                withAnimation {
                                    selecionado1 = i
                                }
                            }) {
                                CardAlternativaExercicio3(idx: i, idExercicio: idExercicio, selecionado: selecionado1, erro: erro1, desativado: desativado[i])
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(desativado[i])
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                            Button (action: {
                                if desativado[i] {
                                    return
                                }
                                withAnimation {
                                    selecionado2 = i
                                }
                            }) {
                                CardAlternativaExercicio3(idx: i, idExercicio: idExercicio, selecionado: selecionado2, erro: erro2, desativado: desativado[i])
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(desativado[i])
                        }
                    }
                    .padding(5)
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .task(id: selecionado1) {
                await checkAcerto()
            }
            .task(id: selecionado2) {
                await checkAcerto()
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                        if estadoFeedback != .neutro {
                            BarraFeedback(
                                mensagem: mensagemErro,
                                estado: estadoFeedback,
                                aoTocar: {
                                    if estadoFeedback == .acerto {
                                        aoConcluirRodada()
                                    }
                                    withAnimation { estadoFeedback = .neutro }
                                }
                            )
                            .ignoresSafeArea(edges: .bottom)
                            .transition(.move(edge: .bottom))
                        }
                    }
                    .animation(.spring(response: 0.35), value: estadoFeedback)
    }
    
    private func checkAcerto() async {
        if estadoFeedback != .neutro {
            return
        }
        
        if (selecionado1 != -1 && selecionado2 != -1) {
            guard selecionado1 < desativado.count, selecionado2 < desativado.count else { return }
            let idx1 = vetor1.firstIndex(where: {$0 == selecionado1})
            let idx2 = vetor2.firstIndex(where: {$0 == selecionado2})
            if (idx1 == idx2) {
                withAnimation {
                    desativado[selecionado1] = true
                    desativado[selecionado2] = true
                }
                selecionado1 = -1
                selecionado2 = -1
            }
            else {
                withAnimation {
                    erro1 = selecionado1
                    erro2 = selecionado2
                    
                    estadoFeedback = .erro
                    mensagemErro = "Essas variáveis não correspondem.Tente outra combinação."

                }

                try? await Task.sleep(nanoseconds: 1_000_000_000)

                withAnimation {
                    erro1 = -1
                    erro2 = -1
                    selecionado1 = -1
                    selecionado2 = -1
                }
            }
            if desativado.allSatisfy({ $0 }) {
                continuarDesativado = false
                
                withAnimation {
                    estadoFeedback = .acerto
                    mensagemErro = ""
                }
            }
        }
    }

}

#Preview {
    Exercicio3View(
        viewModel: TrilhaViewModel(),
        idAtividade: "atv_exemplo",
        aoConcluirRodada: {},
        idExercicio: 0,
        numeroExercicios: 5,
        exercicioAtual: 1,
        vetor1: [0, 1, 2],
        vetor2: [3, 4, 5],
        desativado: [false, false, false, false, false, false]
    )
}
