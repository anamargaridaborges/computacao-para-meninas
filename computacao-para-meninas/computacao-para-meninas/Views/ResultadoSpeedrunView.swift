//
//  ResultadoSpeedrunView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import SwiftUI

struct ResultadoSpeedrunView: View {

    let certas: Int
    let aoJogarDeNovo: () -> Void
    let aoSair: () -> Void

    var body: some View {
        ZStack {
            Color("Color2Button").ignoresSafeArea(edges: .all)

            VStack(spacing: 24) {
                Spacer()

                Text("Tempo esgotado!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.white)

                HStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                    Text("\(certas)")
                        .font(.system(size: 72, weight: .bold))
                }
                .foregroundStyle(Color.white)

                Text(certas == 1 ? "questão resolvida" : "questões resolvidas")
                    .font(.title3)
                    .foregroundStyle(Color.white)

                Spacer()

                Button(action: aoJogarDeNovo) {
                    BotaoContinuar(texto: "Jogar de novo")
                }

                Button(action: aoSair) {
                    Text("Sair")
                        .foregroundStyle(Color.white)
                        .bold()
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResultadoSpeedrunView(certas: 7, aoJogarDeNovo: {}, aoSair: {})
}
