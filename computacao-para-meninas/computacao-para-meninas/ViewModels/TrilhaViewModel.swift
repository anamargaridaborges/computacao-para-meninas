//
//  TrilhaViewModel.swift
//  
//
//  Created by Ana Macedo on 12/04/26.
//

import SwiftUI
import Observation

@Observable
class TrilhaViewModel {
    private let userDefaultsKey = "atividadesConcluidas"
    var idsConcluidos: Set<String> = [] {
        didSet {
            saveProgress()
        }
    }
    
    let nomeModulo: String = "Variáveis"
    var botoesTrilha: [BotaoTrilha] = []

    init() {
        loadProgress()
        loadTrilhaData()
    }

    private func loadTrilhaData() {
        self.botoesTrilha = [
            BotaoTrilha(id: "atv_1", idDependencia: nil, titulo: "Exercício 1", icone: "</>", offsetX: -80),
            BotaoTrilha(id: "atv_2", idDependencia: "atv_1", titulo: "Exercício 2", icone: "#", offsetX: 110),
            BotaoTrilha(id: "atv_4", idDependencia: "atv_3", titulo: "Exercício 4", icone: "%", offsetX: -30),
            BotaoTrilha(id: "historia_1", idDependencia: "atv_4", titulo: "O Desafio dos Tipos", icone: "book.pages.fill", offsetX: -100, tipo: .historia, usaSFSymbol: true)
        ]
    }

    func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            idsConcluidos = decoded
        }
    }

    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(idsConcluidos) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    func estaDesbloqueada(idAtividade: String, idDependencia: String?) -> Bool {
        guard let dependencia = idDependencia else { return true }
        return idsConcluidos.contains(dependencia)
    }

    func concluirAtividade(id: String) {
        idsConcluidos.insert(id)
    }
}
