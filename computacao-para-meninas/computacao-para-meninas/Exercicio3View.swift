//
//  Exercicio3View.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import SwiftUI

struct Exercicio3View: View {
    
    let idExercicio: Int
    let numeroExercicios: Int
    let exercicioAtual: Int

    var body: some View {
            VStack {
                HStack {
                    Button (action: {}) {
                        Image("ActivityBack")
                    }
                    .padding()
                    Spacer()
                    BarraDeProgresso(numeroExercicios: numeroExercicios, exercicioAtual: exercicioAtual)
                    Spacer()
                    Button (action: {}) {
                        Image("Doubt")
                    }
                    .padding()
                }
                HStack {
                    Text(exercicios[idExercicio].enunciado)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                .padding()
                HStack {
                    VStack {
                        ForEach(0..<exercicios[idExercicio].alternativas.count / 2, id : \.self) { i in
                            CardAlternativaExercicio3(idx: i, idExercicio: idExercicio)
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                            CardAlternativaExercicio3(idx: i, idExercicio: idExercicio)
                        }
                    }
                    .padding(5)
                }
                Button(action: {}) {
                    BotaoContinuar()
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
    }

}

#Preview {
    //Exercicio3View(idExercicio: 0)
}
