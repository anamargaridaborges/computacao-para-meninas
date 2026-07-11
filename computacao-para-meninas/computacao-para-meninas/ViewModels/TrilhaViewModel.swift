//
//  TrilhaViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Macedo on 12/04/26.
//

import SwiftUI
import Observation

@Observable
class TrilhaViewModel {
    private let userDefaultsKey = "atividadesConcluidas"
    private let pontosKey = "pontosTotaisXP"
    
    var idsConcluidos: Set<String> = [] {
        didSet {
            saveProgress()
        }
    }
    
    var pontosTotais: Int = 0 {
        didSet {
            savePontos()
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
            BotaoTrilha(
                id: "Variaveis",
                idDependencia: nil,
                titulo: "Variáveis",
                icone: "</>",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "TiposDeDados",
                idDependencia: "Variaveis",
                titulo: "Tipos de Dados",
                icone: "#",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "Condicionais",
                idDependencia: "TiposDeDados",
                titulo: "Condicionais",
                icone: "%",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "Operadores",
                idDependencia: "Condicionais",
                titulo: "Operadores",
                icone: "%",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "Loops",
                idDependencia: "Operadores",
                titulo: "Loops",
                icone: "%",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "Listas",
                idDependencia: "Loops",
                titulo: "Listas",
                icone: "%",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "Funcoes",
                idDependencia: "Listas",
                titulo: "Funções",
                icone: "%",
                offsetX: 0
            ),
            BotaoTrilha(
                id: "historia_1",
                idDependencia: "Funcoes",
                titulo: "O Desafio dos Tipos",
                icone: "book.pages.fill",
                offsetX: 0,
                tipo: .historia,
                usaSFSymbol: true
            )
        ]
    }

    func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            idsConcluidos = decoded
        }
        
        pontosTotais = UserDefaults.standard.integer(forKey: pontosKey)
    }

    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(idsConcluidos) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func savePontos() {
        UserDefaults.standard.set(pontosTotais, forKey: pontosKey)
    }

    func estaDesbloqueada(idAtividade: String, idDependencia: String?) -> Bool {
        guard let dependencia = idDependencia else { return true }
        return idsConcluidos.contains(dependencia)
    }

    func concluirAtividade(id: String) {
        if !idsConcluidos.contains(id) {
            idsConcluidos.insert(id)
            pontosTotais += 50
        }
    }
}
