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
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("LightestGray"))
                                    .stroke(Color("Gray"), lineWidth: 4)
                                    .frame(width: 150, height: 130)
                                Text(exercicios[idExercicio].alternativas[i])
                                    .frame(width: 120)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("LightestGray"))
                                    .stroke(Color("Gray"), lineWidth: 4)
                                    .frame(width: 150, height: 130)
                                Text(exercicios[idExercicio].alternativas[i])
                                    .frame(width: 120)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                        }
                    }
                    .padding(5)
                }
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("AccentColor"))
                            .frame(width: 350, height: 50)
                        Text("Continuar")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
    }

}

#Preview {
    //Exercicio3View(idExercicio: 0)
}
