//
//  RelacionarColunasViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import Foundation
import SwiftUI

@Observable
class RelacionarColunasViewModel {
    let vetor1: [Int]
    let vetor2: [Int]
    
    let exercicio: Exercicio

    var selecionado1: Int = -1
    var selecionado2: Int = -1
    var erro1: Int = -1
    var erro2: Int = -1
    var desativado: [Bool]
    var continuarDesativado: Bool = true
    var estadoFeedback: EstadoFeedback = .neutro

    let aoConcluirRodada: () -> Void

    init(vetor1: [Int], vetor2: [Int], exercicio: Exercicio, aoConcluirRodada: @escaping () -> Void) {
        self.vetor1 = vetor1
        self.vetor2 = vetor2
        guard case .relacionarColunas = exercicio.tipo else {
            fatalError("RelacionarColunasViewModel necessita de um exercício do tipo .relacionarColunas")
        }
        self.exercicio = exercicio
        self.desativado = Array(repeating: false, count: exercicio.alternativas.count)
        self.aoConcluirRodada = aoConcluirRodada
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
                }
            }
        }
    }
}
