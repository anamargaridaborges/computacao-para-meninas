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
        ZStack (alignment: .bottom) {
            cor.opacity(0.15)
                .ignoresSafeArea(edges: .bottom)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: isAcerto ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(cor)
                    Text(isAcerto ? "Excelente!" : "Incorreto")
                        .font(.system(.subheadline, design: .rounded, weight: .bold))
                        .foregroundStyle(cor)
                }
                
                if !isAcerto && !mensagem.isEmpty {
                    Text(mensagem)
                        .font(.system(.callout, design: .rounded))
                        .foregroundStyle(Color("Wrong"))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
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
                .padding(.bottom, 30)
                .padding(.top, (isAcerto ? 20 : 0))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
        }
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
