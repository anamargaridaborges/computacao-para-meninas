//
//  CardPersonagem.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 11/07/26.
//

import SwiftUI

struct CardPersonagem: View {
    let personagem: Personagem
    let desbloqueada: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image(personagem.imagem)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color("LightestGray"))
                .saturation(desbloqueada ? 1 : 0)
                .opacity(desbloqueada ? 1 : 0.6)

            HStack(spacing: 6) {
                Text(personagem.nome)
                    .font(.system(.headline, design: .rounded, weight: .bold))
                    .foregroundStyle(Color("Text"))

                if !desbloqueada {
                    Image(systemName: "lock.fill")
                        .font(.subheadline)
                        .foregroundStyle(Color("Text").opacity(0.5))
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(desbloqueada ? Color("AccentColor").opacity(0.35) : Color("LightGray"))
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Text").opacity(0.15), lineWidth: 1)
        )
        .accessibilityIdentifier("personagem_\(personagem.id)")
        .accessibilityLabel(desbloqueada ? "\(personagem.nome), desbloqueada" : "\(personagem.nome), bloqueada")
    }
}
