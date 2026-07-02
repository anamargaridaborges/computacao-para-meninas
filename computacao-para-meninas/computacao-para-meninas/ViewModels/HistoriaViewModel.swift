//
//  HistoriaViewModel.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 22/06/26.
//

import Foundation
import SwiftUI

@Observable
class HistoriaViewModel {
    var noAtual: NoHistoria
    var historiaFinalizada: Bool = false
    
    let onConcluirAtividade: () -> Void
    
    private let chaveProgresso = "historiasConcluidas"
    private(set) var idsConcluidos: Set<String> = []
    
    private let historia: Historia
    private var mapaDeNos: [String: NoHistoria] = [:]
    
    init(historia: Historia, onConcluirAtividade: @escaping () -> Void) {
        self.historia = historia
        self.onConcluirAtividade = onConcluirAtividade

        var tempMapa: [String: NoHistoria] = [:]
        for no in historia.nos {
            tempMapa[no.id] = no
        }

        guard let primeiroNo = tempMapa[historia.noInicial] else {
            fatalError("Nó inicial '\(historia.noInicial)' não encontrado.")
        }

        self.noAtual = primeiroNo
        self.mapaDeNos = tempMapa

        carregarProgresso()
    }
    
    func avancar(paraId id: String) {
        guard let proximo = mapaDeNos[id] else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            noAtual = proximo
        }
        if proximo.tipo == .fim {
            concluirHistoria()
        }
    }
    
    func avancarProximo() {
        guard let id = noAtual.proximoNo else { return }
        avancar(paraId: id)
    }
    
    func escolher(_ escolha: Escolha) {
        avancar(paraId: escolha.proximoNo)
    }
    
    func historiaJaConcluida() -> Bool {
        return idsConcluidos.contains(historia.id)
    }
    
    private func concluirHistoria() {
        historiaFinalizada = true
        idsConcluidos.insert(historia.id)
        salvarProgresso()
    }
    
    private func salvarProgresso() {
        if let encoded = try? JSONEncoder().encode(idsConcluidos) {
            UserDefaults.standard.set(encoded, forKey: chaveProgresso)
        }
    }

    private func carregarProgresso() {
        if let data = UserDefaults.standard.data(forKey: chaveProgresso),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            idsConcluidos = decoded
        }
    }
}
