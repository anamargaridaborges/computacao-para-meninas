//
//  ModoSpeedrunViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 10/07/26.
//

import Foundation
import Observation

@Observable
class ModoSpeedrunViewModel {
    var questoes: [Exercicio]
    var idxAtual: Int = 0
    var certas: Int = 0
    var endDate: Date = Date().addingTimeInterval(60)
    var terminado: Bool = false

    var exercicioAtual: Exercicio {
        questoes[idxAtual]
    }

    init() {
        let carregadas: [Exercicio] = loadIfPresent("ModoSpeedrunQuestoes.json") ?? []
        self.questoes = carregadas.shuffled()
    }

    func iniciarCronometro() {
        endDate = Date().addingTimeInterval(60)
    }

    func registrarAcerto() {
        certas += 1
        guard !questoes.isEmpty else { return }
        idxAtual = (idxAtual + 1) % questoes.count
    }

    func verificarTempo() {
        if Date() >= endDate {
            terminado = true
        }
    }

    func reiniciar() {
        questoes = questoes.shuffled()
        idxAtual = 0
        certas = 0
        terminado = false
        iniciarCronometro()
    }
}
