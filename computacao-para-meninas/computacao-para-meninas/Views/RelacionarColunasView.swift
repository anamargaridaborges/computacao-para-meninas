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
                            let alternativa = viewModel.exercicio.alternativas[i]
                            let desativado = viewModel.desativado[i] || viewModel.estadoFeedback == .erro
                            
                            Button(action: { viewModel.selecionarColuna1(i) }) {
                                CardAlternativaRelacionarColunas(
                                    estado: estadoDoCard(index: i, selecionado: viewModel.selecao.idPrimeiraColuna),
                                    alternativa: alternativa
                                )
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(desativado)
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(viewModel.exercicio.alternativas.count / 2..<viewModel.exercicio.alternativas.count, id : \.self) { i in
                            let alternativa = viewModel.exercicio.alternativas[i]
                            let desativado = viewModel.desativado[i] || viewModel.estadoFeedback == .erro
                            
                            
                            Button(action: { viewModel.selecionarColuna2(i) }) {
                                CardAlternativaRelacionarColunas(
                                    estado: estadoDoCard(index: i, selecionado: viewModel.selecao.idSegundaColuna),
                                    alternativa: alternativa
                                )
                            }
                            .accessibilityIdentifier("card_\(i)")
                            .disabled(desativado)
                        }
                    }
                    .padding(5)
                }

                Spacer()
            }
            .navigationBarBackButtonHidden()
            .task(id: viewModel.selecao.idPrimeiraColuna) {
                await viewModel.checkAcerto()
            }
            .task(id: viewModel.selecao.idSegundaColuna) {
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
                            withAnimation { viewModel.resetar() }
                        }
                    )
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring(response: 0.35), value: viewModel.estadoFeedback)
    }

    func estadoDoCard(index: Int, selecionado: Int?) -> CardAlternativaRelacionarColunas.Estado {
        let desativado = viewModel.desativado[index]
        
        if desativado {
            return .desativado
        } else if index == selecionado {
            if viewModel.estadoFeedback == .erro {
                return .erro
            }
            return .selecionado
        }
        
        return .normal
    }
}
