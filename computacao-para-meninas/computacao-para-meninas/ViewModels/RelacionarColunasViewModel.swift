//
//  RelacionarColunasViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import Foundation
import SwiftUI

@MainActor
class RelacionarColunasViewModel: ObservableObject {

    let idExercicio: Int
    let vetor1: [Int]
    let vetor2: [Int]

    @Published var selecionado1: Int = -1
    @Published var selecionado2: Int = -1
    @Published var erro1: Int = -1
    @Published var erro2: Int = -1
    @Published var desativado: [Bool]
    @Published var continuarDesativado: Bool = true
    @Published var estadoFeedback: EstadoFeedback = .neutro
    @Published var mensagemErro: String = ""

    init(idExercicio: Int, vetor1: [Int], vetor2: [Int]) {
        self.idExercicio = idExercicio
        self.vetor1 = vetor1
        self.vetor2 = vetor2
        self.desativado = Array(repeating: false, count: exercicios[idExercicio].alternativas.count)
    }

    func selecionarColuna1(_ i: Int) {
        if desativado[i] { return }
        withAnimation {
            selecionado1 = i
        }
    }

    func selecionarColuna2(_ i: Int) {
        if desativado[i] { return }
        withAnimation {
            selecionado2 = i
        }
    }

    func checkAcerto() async {
        if estadoFeedback != .neutro {
            return
        }

        if (selecionado1 != -1 && selecionado2 != -1) {
            guard selecionado1 < desativado.count, selecionado2 < desativado.count else { return }
            let idx1 = vetor1.firstIndex(where: {$0 == selecionado1})
            let idx2 = vetor2.firstIndex(where: {$0 == selecionado2})
            if (idx1 == idx2) {
                withAnimation {
                    desativado[selecionado1] = true
                    desativado[selecionado2] = true
                }
                selecionado1 = -1
                selecionado2 = -1
            }
            else {
                withAnimation {
                    erro1 = selecionado1
                    erro2 = selecionado2

                    estadoFeedback = .erro
                    mensagemErro = "Essas variáveis não correspondem. Tente outra combinação."

                }

                try? await Task.sleep(nanoseconds: 1_000_000_000)

                withAnimation {
                    erro1 = -1
                    erro2 = -1
                    selecionado1 = -1
                    selecionado2 = -1
                }
            }
            if desativado.allSatisfy({ $0 }) {
                continuarDesativado = false

                withAnimation {
                    estadoFeedback = .acerto
                    mensagemErro = ""
                }
            }
        }
    }
}
