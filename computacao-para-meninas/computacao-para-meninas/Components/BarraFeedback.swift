//
//  BarraFeedback.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 14/04/26.
//

import SwiftUI

struct BarraFeedback: View {
    let mensagem: String
    let estado: EstadoFeedback
    let aoTocar: () -> Void
    
    private var isAcerto: Bool { estado == .acerto }
    private var cor: Color { isAcerto ? Color("AccentColor") : Color("Wrong") }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: isAcerto ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(cor)
                    Text(isAcerto ? "Excelente!!" : "Incorreto")
                        .font(.system(.subheadline, design: .rounded, weight: .bold))
                        .foregroundStyle(cor)
                }
                
                if !isAcerto && !mensagem.isEmpty {
                    Text(mensagem)
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(Color("Text"))
                }
                
                Button(action: aoTocar) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(cor)
                            .frame(height: 50)
                        Text(isAcerto ? "Continuar" : "Tentar de novo")
                            .foregroundStyle(Color.white)
                            .font(.system(.body, design: .rounded, weight: .bold))
                    }
                }
            }
            .padding(.horizontal, 20) // conteúdo com margem
        }
        .padding(.top, 20)
        .padding(.bottom, 20) // 👈 pode usar safeArea depois se quiser
        .frame(maxWidth: .infinity)
        .background(cor.opacity(0.15))
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        Color.purple.opacity(0.15)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 34)
        BarraFeedback(mensagem: "", estado: .acerto) {}
    }
}

#Preview("Erro") {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        Color.red.opacity(0.15)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 34)
        BarraFeedback(
            mensagem: "Cada variável tem apenas um tipo certo. Olhe o valor dela — listas usam colchetes [ ], números com ponto são float, e textos ficam entre aspas.",
            estado: .erro
        ) {}
    }
}
