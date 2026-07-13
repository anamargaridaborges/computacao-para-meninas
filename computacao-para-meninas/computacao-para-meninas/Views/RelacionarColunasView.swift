import SwiftUI

struct RelacionarColunasView: View {
    @State private var viewModel: RelacionarColunasViewModel
    @Environment(\.dismiss) var dismiss
    
    init(
        viewModel: RelacionarColunasViewModel,
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
            VStack {
                HStack {
                    VStack {
                        ForEach(0..<viewModel.exercicio.alternativas.count / 2, id : \.self) { i in
                            Button (action: {
                                viewModel.selecionarColuna1(i)
                            }) {
                                CardAlternativaRelacionarColunas(idx: i, selecionado: viewModel.selecionado1, erro: viewModel.erro1, desativado: viewModel.desativado[i], alternativa: viewModel.exercicio.alternativas[i])
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(viewModel.desativado[i])
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(viewModel.exercicio.alternativas.count / 2..<viewModel.exercicio.alternativas.count, id : \.self) { i in
                            Button (action: {
                                viewModel.selecionarColuna2(i)
                            }) {
                                CardAlternativaRelacionarColunas(idx: i, selecionado: viewModel.selecionado2, erro: viewModel.erro2, desativado: viewModel.desativado[i], alternativa: viewModel.exercicio.alternativas[i])
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
            .overlay {
                if viewModel.estadoFeedback != .neutro {
                    BarraFeedback(
                        estado: viewModel.estadoFeedback,
                        explicacao: viewModel.exercicio.explicacao,
                        aoTocar: {
                            if viewModel.estadoFeedback == .acerto {
                                viewModel.aoConcluirRodada()
                            }
                            withAnimation { viewModel.estadoFeedback = .neutro }
                        }
                    )
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring(response: 0.35), value: viewModel.estadoFeedback)
    }

}
