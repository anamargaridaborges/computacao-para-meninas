import SwiftUI

struct ModoSpeedrunView: View {

    @State var viewModel = ModoSpeedrunViewModel()
    @State var tempoRestante: Int = 4
    @State private var rodadaID = UUID()

    @Environment(\.dismiss) var dismiss

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        if viewModel.terminado {
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
            ZStack {
                // O jogo é montado desde já (mesmo escondido) para "esquentar"
                // o primeiro render durante a contagem regressiva, evitando o
                // travamento que comia tempo do cronômetro.
                //
                // O `.id(rodadaID)` garante que, após o embaralhamento feito no
                // `onAppear`, todo o subtree do jogo receba identidade nova e
                // reconstrua os ViewModels dos exercícios — senão a primeira
                // questão ficaria com o VM (alternativas) da questão pré-shuffle.
                jogo
                    .id(rodadaID)

                if tempoRestante > 0 {
                    CountdownView(tempoRestante: $tempoRestante)
                }
            }
            .onAppear {
                // Reembaralha ao começar a rodada (durante a contagem), para
                // que a questão aquecida seja a que será jogada. Renova o
                // rodadaID para reconstruir o jogo já com as questões
                // embaralhadas (evita mistura de enunciado com alternativas).
                if tempoRestante > 0 {
                    viewModel.embaralhar()
                    rodadaID = UUID()
                }
            }
            .onChange(of: tempoRestante) { _, novo in
                if novo == 0 {
                    viewModel.iniciarCronometro()
                }
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

    private var jogo: some View {
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onReceive(timer) { _ in
            viewModel.verificarTempo()
        }
    }
}

#Preview {
    ModoSpeedrunView()
}
