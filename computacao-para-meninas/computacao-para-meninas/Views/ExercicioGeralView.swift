//
//  ExercicioGeralView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct ExercicioGeralView: View {
    @State var viewModel: ExercicioGeralViewModel
    
//=======
//    @State var totalDeRodadas: Int = 0
//    @State var estadoFeedback: EstadoFeedback = .neutro
//    let mensagemErro: String = "Para realizar uma soma com num1, preciso que essa variável armazene um inteiro."
//    @State var idSelecionado: Int = -1
//    
//>>>>>>> main
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
            VStack {
                // aqui vai resetando os cards a cada licao
                switch viewModel.exercicioAtual.tipo {
                case .ordenar(let vetor):
                    let vm = OrdenarViewModel(
                        numeroExercicios: viewModel.totalRodadas,
                        vetor: vetor,
                        aoConcluirRodada: {
                            viewModel.proximaEtapa()
                        }
                    )
                    ExercicioOrdenarView(ordenarViewModel: vm)
                        .id(viewModel.rodadaAtual)
                case .relacionarColunas(let primeiro, let segundo):
                    let vm = RelacionarColunasViewModel(
                        vetor1: primeiro,
                        vetor2: segundo,
                        exercicio: viewModel.exercicioAtual,
                        aoConcluirRodada: {
                            viewModel.proximaEtapa()
                        }
                    )
                    
                    RelacionarColunasView(
                        viewModel: vm,
                    )
                    .id(viewModel.rodadaAtual)
                    
                case .multiplaEscolha(let resposta, let codigo):
                    let vm = MultiplaEscolhaViewModel(
                        resposta: resposta,
                        codigo: codigo,
                        exercicio: viewModel.exercicioAtual,
                        onConcluirAtividade: {
                            viewModel.proximaEtapa()
                        })
                    
                    MultiplaEscolhaView(
                        viewModel: vm,
                        resposta: resposta,
                        codigo: codigo
                    )
                    .id(viewModel.rodadaAtual)
                case .curiosidade(let conteudo):
                    ExercicioCuriosidadeView(
                        aoConcluirRodada: {
                            viewModel.proximaEtapa()
                        },
                    curiosidade: conteudo)

                case .conteudoTeorico(let texto, let imagem, let dica):
                    let vm = ExercicioTeoricoViewModel(
                        exercicio: viewModel.exercicioAtual,
                        texto: texto,
                        imagem: imagem,
                        dica: dica,
                        onConcluirAtividade: {
                            viewModel.proximaEtapa()
                        })
                    ExercicioTeoricoView(viewModel: vm)
                        .id(viewModel.rodadaAtual)
                }
                Spacer()
            }
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
//            .safeAreaInset(edge: .bottom, spacing: 0) {
//                if estadoFeedback != .neutro, case .tipo1 = exercicios[rodadaAtual].tipo {
//                    BarraFeedback(
//                        mensagem: mensagemErro,
//                        estado: estadoFeedback,
//                        aoTocar: {
//                            if estadoFeedback == .acerto {
//                                proximaEtapa()
//                            }
//                            withAnimation { estadoFeedback = .neutro
//                            idSelecionado = -1 }
//                        }
//                    )
//                    .ignoresSafeArea(edges: .bottom)
//                    .transition(.move(edge: .bottom))
//                    .frame(maxHeight: (estadoFeedback == .acerto ? 80 : .infinity))
//                }
//            }
//            .animation(.spring(response: 0.35), value: estadoFeedback)
        }
        // na View
    }
}

//#Preview {
//    ExercicioGeralView(viewModel: TrilhaViewModel(), idx: 0, idAtividade: "atv_1")
//}

