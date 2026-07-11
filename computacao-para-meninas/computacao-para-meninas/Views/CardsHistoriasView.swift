//
//  CardsHistoriasView.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 11/07/26.
//

import SwiftUI

struct CardsHistoriasView: View {
    @State private var viewModel = HistoriasViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.personagens) { personagem in
                                let desbloqueada = viewModel.estaDesbloqueada(personagem)

                                Group {
                                    if desbloqueada {
                                        NavigationLink {
                                            HistoriaPersonagemView(personagem: personagem)
                                        } label: {
                                            CardPersonagem(personagem: personagem, desbloqueada: true)
                                        }
                                        .buttonStyle(.plain)
                                    } else {
                                        CardPersonagem(personagem: personagem, desbloqueada: false)
                                    }
                                }
                            }
                        }
                        .padding(20)
                    }
                }
            }
        }
        .onAppear { viewModel.carregarProgresso() }
    }

    private var header: some View {
        HStack {

            Spacer()

            HStack(spacing: 4) {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(.yellow)
                Text("\(viewModel.pontosTotais)")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(Color("Text"))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color("AccentColor").opacity(0.25))
    }
}

#Preview {
    CardsHistoriasView()
}
