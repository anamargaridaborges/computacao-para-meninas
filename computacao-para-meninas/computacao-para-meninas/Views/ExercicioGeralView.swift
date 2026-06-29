//
//  ExercicioGeralView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 08/04/26.
//

import SwiftUI

struct ExercicioGeralView: View {
    var viewModel: TrilhaViewModel
    var idx: Int
    let idAtividade: String
    @State private var rodadaAtual: Int = 0

    let totalDeRodadas: Int

    @Environment(\.dismiss) var dismiss
    

    var ehConteudoTeorico: Bool {
        if case .conteudoTeorico = exercicios[rodadaAtual].tipo { return true }
        return false
    }


    init(viewModel: TrilhaViewModel, idx: Int, idAtividade: String, rodadaAtual: Int=0) {
        self.viewModel = viewModel
        self.idx = idx
        self.idAtividade = idAtividade
        _rodadaAtual = State(initialValue: rodadaAtual)

        self.totalDeRodadas = exercicios.count
    }
    
    var body: some View {
            VStack {
                // aqui vai resetando os cards a cada licao
                switch exercicios[rodadaAtual].tipo {
                case .ordenar(let vetor):
                    let vm = OrdenarViewModel(
                        idAtividade: idAtividade,
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        vetor: vetor,
                        aoConcluirRodada: {
                            proximaEtapa()
                        }
                    )
                    ExercicioOrdenarView(ordenarViewModel: vm)
                    .id(rodadaAtual)
                case .relacionarColunas(let primeiro, let segundo):
                    RelacionarColunasView(
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        vetor1: primeiro,
                        vetor2: segundo
                    )
                    .id(rodadaAtual)
                    
                case .multiplaEscolha(let resposta, let codigo):
                    MultiplaEscolhaView(
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        resposta: resposta,
                        codigo: codigo
                    )
                    .id(rodadaAtual)
                case .curiosidade(let conteudo):
                    ExercicioCuriosidadeView(
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                    curiosidade: conteudo)

                case .conteudoTeorico(let texto, let imagem, let dica):
                    ExercicioTeoricoView(
                        idAtividade: idAtividade,
                        aoConcluirRodada: {
                            proximaEtapa()
                        },
                        idExercicio: rodadaAtual,
                        numeroExercicios: totalDeRodadas,
                        exercicioAtual: rodadaAtual,
                        texto: texto,
                        imagem: imagem,
                        dica: dica
                    )
                    .id(rodadaAtual)
                }
                Spacer()
            }
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        // se clicar em voltar, sai de tudo e volta para a home
                        Button (action: {
                            if (rodadaAtual == 0) {
                                dismiss()
                            }
                            else {
                                rodadaAtual -= 1
                            }
                        }) {
                            Image("ActivityBack")
                        }
                        .padding()
                        Spacer()
                        BarraDeProgresso(numeroExercicios: totalDeRodadas, exercicioAtual: rodadaAtual+1)
                            .animation(.spring(response: 1.0, dampingFraction: 0.7), value: rodadaAtual)
                        Spacer()
                        Button (action: {}) {
                            Image("Doubt")
                        }
                        .padding()
                    }
                    
                    // Personagem no canto do enunciado (escondido no conteúdo teórico)
                    if !ehConteudoTeorico {
                        HStack(alignment: .bottom, spacing: 12) {
                            Image(rodadaAtual % 2 == 0 ? "AdaLovelace" : "KatherineExercicio")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .padding(.leading, 12)

                            Text(exercicios[rodadaAtual].enunciado)
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
    }
    
    func proximaEtapa() {
        if rodadaAtual < totalDeRodadas - 1 {
            rodadaAtual += 1
        } else {
            viewModel.concluirAtividade(id: idAtividade)
            dismiss()
        }
    }
}
#Preview {
    ExercicioGeralView(viewModel: TrilhaViewModel(), idx: 0, idAtividade: "atv_1")}
