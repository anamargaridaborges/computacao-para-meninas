import SwiftUI

struct ExercicioGeralView: View {
    @State var viewModel: ExercicioGeralViewModel
    @Environment(\.dismiss) var dismiss

    var ehConteudoTeorico: Bool {
        if case .conteudoTeorico = viewModel.exercicioAtual.tipo { return true }
        return false
    }

    init(viewModel: ExercicioGeralViewModel, rodadaAtual: Int=0) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.totalRodadas == 0 {
            Text("Sem exercícios para esta atividade.")
        } else {
            viewModel.exercicioAtual.tipo.strategy.criarView(
                exercicio: viewModel.exercicioAtual,
                rodadaAtual: viewModel.rodadaAtual,
                aoConcluirRodada: { viewModel.proximaEtapa() }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        // se clicar em voltar, sai de tudo e volta para a home
                        Button (action: {
                            if (viewModel.rodadaAtual == 0) {
                                dismiss()
                            }
                            else {
                                viewModel.rodadaAtual -= 1
                            }
                        }) {
                            Image("ActivityBack")
                        }
                        .padding()
                        Spacer()
                        BarraDeProgresso(numeroExercicios: viewModel.totalRodadas, exercicioAtual: viewModel.rodadaAtual+1)
                            .animation(.spring(response: 1.0, dampingFraction: 0.7), value: viewModel.rodadaAtual)
                        Spacer()
                        Button (action: {}) {
                            Image("Doubt")
                        }
                        .padding()
                    }
                    
                    // Personagem no canto do enunciado (escondido no conteúdo teórico)
                    if !ehConteudoTeorico {
                        HStack(alignment: .bottom, spacing: 12) {
                            Image(viewModel.rodadaAtual % 2 == 0 ? "AdaLovelace" : "KatherineExercicio")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .padding(.leading, 12)

                            Text(viewModel.exercicioAtual.enunciado)
                                .font(.title2)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.trailing, 12)
                                .padding(.bottom, 8)

                            Spacer()
                        }
                        .padding(.bottom, 12)
                    }

                }
            }
            .onChange(of: viewModel.concluido) { _, novo in
                if novo { dismiss() }
            }
        }
    }
}
