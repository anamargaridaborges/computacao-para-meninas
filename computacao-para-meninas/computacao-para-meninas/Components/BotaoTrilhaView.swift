//
//  BotaoTrilhaView.swift
//  computacao-para-meninas
//
//  Created by Ana Macedo on 27/06/26.
//

import SwiftUI

struct BotaoTrilhaView: View {
    let icone: String
    let titulo: String
    let estaLivre: Bool
    var isHistoria: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(estaLivre ? Color("Color2Button") : Color("Gray"))
                    .frame(width: 80, height: 80)
                    .offset(x: 5, y: 5)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(estaLivre ? Color("Color1Button") : Color("Color3Button"))
                    .frame(width: 80, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(estaLivre ? Color("Color2Button") : Color("Gray"), lineWidth: 3)
                    )

                if isHistoria {
                    Image(systemName: icone)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.black)
                } else {
                    Text(icone)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)
                }
            }

            Text(titulo)
                .font(.system(.caption, design: .rounded, weight: .bold))
                .foregroundStyle(estaLivre ? Color("AccentColor") : Color("Gray"))
        }
    }
}
