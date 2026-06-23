//
//  DialogoView.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 22/06/26.
//

import SwiftUI

struct DialogoView: View {
    @ObservedObject var viewModel: HistoriaViewModel
    let no: NoHistoria
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(alignment: .bottom, spacing: 0) {
                Image("AdaLovelace")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 8) {
                    if let fala = no.fala {
                        BalaoDeFala(texto: fala)
                            .transition(.opacity.combined(with: .move(edge: .trailing)))
                    }

                    if let codigo = no.codigoExemplo {
                        Text(codigo)
                            .font(.system(.body, design: .monospaced, weight: .medium))
                            .foregroundStyle(Color.green)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black.opacity(0.85))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                if no.tipo == .escolha, let escolhas = no.escolhas {
                    VStack(spacing: 10) {
                        ForEach(escolhas) { escolha in
                            Button {
                                withAnimation { viewModel.escolher(escolha) }
                            } label: {
                                Text(escolha.texto)
                                    .font(.system(.body, design: .rounded, weight: .semibold))
                                    .foregroundStyle(Color.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 20)
                                    .background(Color("LightGray"))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("Gray"), lineWidth: 2)
                                    )
                            }
                            .accessibilityIdentifier("escolha_\(escolha.id)")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                } else {
                    Button {
                        withAnimation { viewModel.avancarProximo() }
                    } label: {
                        BotaoContinuar()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .animation(.spring(response: 0.4), value: no.id)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

struct BalaoDeFala: View {
    let texto: String
    
    var body: some View {
        Text(texto)
            .font(.system(.body, design: .rounded))
            .foregroundStyle(Color("Text"))
            .fixedSize(horizontal: false, vertical: true)
            .padding(16)
            .background(Color("LightestGray"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("AccentColor").opacity(0.25), lineWidth: 1.5)
            )
    }
}
