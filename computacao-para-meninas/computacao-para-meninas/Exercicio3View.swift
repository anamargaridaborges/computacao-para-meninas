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
    @State var selecionado1: Int = -1
    @State var selecionado2: Int = -1
    @State var erro1: Int = -1
    @State var erro2: Int = -1
    let vetor1: [Int]
    let vetor2: [Int]
    @State var desativado: [Bool]
    @State var continuarDesativado: Bool = true

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
                            CardAlternativaExercicio3(idx: i, idExercicio: idExercicio, selecionado: selecionado1, erro: erro1, desativado: desativado[i])
                                .onTapGesture {
                                    if desativado[i] {
                                        return
                                    }
                                    selecionado1 = i
                                }
                        }
                    }
                    .padding(5)

                    VStack {
                        ForEach(exercicios[idExercicio].alternativas.count / 2..<exercicios[idExercicio].alternativas.count, id : \.self) { i in
                            CardAlternativaExercicio3(idx: i, idExercicio: idExercicio, selecionado: selecionado2, erro: erro2, desativado: desativado[i])
                                .onTapGesture {
                                    if desativado[i] {
                                        return
                                    }
                                    selecionado2 = i
                                }
                        }
                    }
                    .padding(5)
                }
                Button(action: {}) {
                    BotaoContinuar(continuarDesativado: continuarDesativado)
                }
                .padding()
                .disabled(continuarDesativado)
            }
            .navigationBarBackButtonHidden()
            .task(id: selecionado1) {
                await checkAcerto()
            }
            .task(id: selecionado2) {
                await checkAcerto()
            }
    }
    
    private func checkAcerto() async {
        if (selecionado1 != -1 && selecionado2 != -1) {
            // comparar e ver se é a resposta certa ou errada
            let idx1 = vetor1.firstIndex(where: {$0 == selecionado1})
            let idx2 = vetor2.firstIndex(where: {$0 == selecionado2})
            if (idx1 == idx2) {
                // acertou
                withAnimation {
                    desativado[selecionado1] = true
                    desativado[selecionado2] = true
                }
                selecionado1 = -1
                selecionado2 = -1
            }
            else {
                // errou
                withAnimation {
                    erro1 = selecionado1
                    erro2 = selecionado2
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                withAnimation {
                    erro1 = -1
                    erro2 = -1
                    selecionado1 = -1
                    selecionado2 = -1
                }
            }
            var check = true
            for des in desativado {
                if (!des) {
                    check = false
                }
            }
            if (check) {
                continuarDesativado = false
            }
        }
    }

}

#Preview {
    //Exercicio3View(idExercicio: 0)
}
