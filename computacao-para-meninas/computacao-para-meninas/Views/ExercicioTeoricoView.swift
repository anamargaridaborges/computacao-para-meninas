//
//  ExercicioTeoricoView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 25/06/26.
//

import SwiftUI

struct ExercicioTeoricoView: View {
    @StateObject private var viewModel: ExercicioTeoricoViewModel
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int

    init(
        idAtividade: String,
        aoConcluirRodada: @escaping () -> Void,
        idExercicio: Int,
        numeroExercicios: Int,
        exercicioAtual: Int,
        texto: String,
        imagem: String?,
        dica: String?
    ) {
        self.idAtividade = idAtividade
        self.aoConcluirRodada = aoConcluirRodada
        self.idExercicio = idExercicio
        self.numeroExercicios = numeroExercicios
        self.exercicioAtual = exercicioAtual
        _viewModel = StateObject(wrappedValue: ExercicioTeoricoViewModel(
            idExercicio: idExercicio,
            texto: texto,
            imagem: imagem,
            dica: dica
        ))
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

            Button(action: aoConcluirRodada) {
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
