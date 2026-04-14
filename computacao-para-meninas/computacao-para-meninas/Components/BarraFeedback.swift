//
//  BarraFeedback.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 14/04/26.
//

import SwiftUI

struct BarraFeedback: View {
    let estado: EstadoFeedback
    let mensagem: String
    let aoTocar: () -> Void

    @Environment(\.safeAreaInsets) private var safeAreaInsets
    private var isAcerto: Bool { estado == .acerto }
    private var cor: Color { isAcerto ? Color("AccentColor") : Color("Wrong") }

    var body: some View {
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
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(cor.opacity(0.15))
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets = .init()
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        Color.purple.opacity(0.15)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 34)
        BarraFeedback(estado: .acerto, mensagem: "") {}
    }
}

#Preview("Erro") {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        Color.red.opacity(0.15)
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 34)
        BarraFeedback(
            estado: .erro,
            mensagem: "Cada variável tem apenas um tipo certo. Olhe o valor dela — listas usam colchetes [ ], números com ponto são float, e textos ficam entre aspas."
        ) {}
    }
}
