//
//  ExercicioTeoricoView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 25/06/26.
//

import SwiftUI

struct ExercicioTeoricoView: View {
    @State private var viewModel: ExercicioTeoricoViewModel

    init(
        viewModel: ExercicioTeoricoViewModel,
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.enunciado)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)

            Text(viewModel.texto)
                .font(.title3)
                .foregroundStyle(Color.black)
                .fixedSize(horizontal: false, vertical: true)

            if let imagem = viewModel.imagemValida {
                Image(imagem)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            if let dica = viewModel.dicaValida {
                CalloutDica(texto: dica)
            }

            Spacer()

            Button(action: viewModel.onConcluirAtividade) {
                BotaoContinuar()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
    }
}

private struct CalloutDica: View {
    let texto: String

    var body: some View {
        HStack(alignment: .top, spacing: 11) {
            Text("💡")
                .font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text("Dica")
                    .font(.system(.subheadline, design: .rounded, weight: .bold))
                    .foregroundStyle(Color.orange)
                Text(texto)
                    .font(.system(.callout, design: .rounded))
                    .foregroundStyle(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(Color.orange.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {

}
