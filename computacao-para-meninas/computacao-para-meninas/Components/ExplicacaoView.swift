//
//  ExplicacaoView.swift
//  computacao-para-meninas
//

import SwiftUI

struct ExplicacaoView: View {
    let explicacao: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text(explicacao)
                    .font(.system(.body, design: .rounded))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Explicação")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    ExplicacaoView(
        explicacao: "Cada variável tem apenas um tipo certo. Olhe o valor dela — listas usam colchetes [ ], números com ponto são float, e textos ficam entre aspas."
    )
}
