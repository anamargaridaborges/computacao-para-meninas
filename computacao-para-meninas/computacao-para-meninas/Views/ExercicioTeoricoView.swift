//
//  ExercicioTeoricoView.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 25/06/26.
//

import SwiftUI

struct ExercicioTeoricoView: View {
    let idAtividade: String
    var aoConcluirRodada: () -> Void
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int
    let texto: String
    let imagem: String?
    let dica: String?
    
    let exercicio: Exercicio

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(exercicio.enunciado)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)

            Text(texto)
                .font(.title3)
                .foregroundStyle(Color.black)
                .fixedSize(horizontal: false, vertical: true)
            
            if let imagem, !imagem.isEmpty {
                Image(imagem)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            if let dica, !dica.isEmpty {
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
