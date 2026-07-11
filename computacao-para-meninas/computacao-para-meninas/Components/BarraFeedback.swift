//
//  BarraFeedback.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 14/04/26.
//

import SwiftUI

struct BarraFeedback: View {
    let estado: EstadoFeedback
    let explicacao: String
    let aoTocar: () -> Void

    @State private var mostrarExplicacao = false

    private var isAcerto: Bool { estado == .acerto }
    private var cor: Color { isAcerto ? Color("AcertoFundo") : Color("ErroFundo") }
    private var corTexto: Color { isAcerto ? Color("AccentColor") : Color("Wrong") }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: isAcerto ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(corTexto)
                    Text(isAcerto ? "Excelente!" : "Incorreto")
                        .font(.system(.subheadline, design: .rounded, weight: .bold))
                        .foregroundStyle(corTexto)
                }

                HStack(spacing: 12) {
                    if !explicacao.isEmpty {
                        Button(action: { mostrarExplicacao = true }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(corTexto, lineWidth: 2)
                                    .frame(height: 50)
                                Text("Por que?")
                                    .foregroundStyle(corTexto)
                                    .font(.system(.body, design: .rounded, weight: .bold))
                            }
                        }
                    }

                    Button(action: aoTocar) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(corTexto)
                                .frame(height: 50)
                            Text(isAcerto ? "Continuar" : "Tentar de novo")
                                .foregroundStyle(Color.white)
                                .font(.system(.body, design: .rounded, weight: .bold))
                        }
                    }
                }
                Text("")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .background(cor)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
        }
        .ignoresSafeArea()
        .sheet(isPresented: $mostrarExplicacao) {
            ExplicacaoView(explicacao: explicacao)
        }
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        BarraFeedback(estado: .acerto, explicacao: "") {}
    }
}

#Preview("Erro") {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        BarraFeedback(
            estado: .erro,
            explicacao: "Cada variável tem apenas um tipo certo. Olhe o valor dela — listas usam colchetes [ ], números com ponto são float, e textos ficam entre aspas."
        ) {}
    }
}
