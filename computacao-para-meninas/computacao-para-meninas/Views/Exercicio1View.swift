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
    @State var idSelecionado: Int = -1
    @State var continuado: Bool = false

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
                }
                
                Button(action: {
                    aoConcluirRodada()
                    continuado = true
                }) {
                    BotaoContinuar(continuarDesativado: !botaoAtivo)
                }
                .padding()
                .disabled(!botaoAtivo)
            }
            .navigationBarBackButtonHidden()
    }

}

#Preview {
    
}
