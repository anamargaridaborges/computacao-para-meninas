//
//  ModoSpeedrunView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import SwiftUI

struct ModoSpeedrunView: View {

    @State var viewModel = ModoSpeedrunViewModel()
    @State var tempoRestante: Int = 4

    @Environment(\.dismiss) var dismiss

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        if tempoRestante > 0 {
            CountdownView(tempoRestante: $tempoRestante)
        }
        else if viewModel.terminado {
            ResultadoSpeedrunView(
                certas: viewModel.certas,
                aoJogarDeNovo: {
                    viewModel.reiniciar()
                    tempoRestante = 4
                },
                aoSair: { dismiss() }
            )
        }
        else {
            VStack {
                BarraTempoSpeedrun(endDate: viewModel.endDate, certas: viewModel.certas)

                Text(viewModel.exercicioAtual.enunciado)
                    .font(.title2)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 12)

                viewModel.exercicioAtual.tipo.strategy.criarView(
                    exercicio: viewModel.exercicioAtual,
                    rodadaAtual: viewModel.idxAtual,
                    aoConcluirRodada: { viewModel.registrarAcerto() }
                )

                Spacer()
            }
            .onAppear {
                viewModel.iniciarCronometro()
            }
            .onReceive(timer) { _ in
                viewModel.verificarTempo()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    ModoSpeedrunView()
}
