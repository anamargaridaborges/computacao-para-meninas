//
//  HistoriaViewModel.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 22/06/26.
//

import Foundation
import SwiftUI

@MainActor
class HistoriaViewModel: ObservableObject {
    
    @Published var noAtual: NoHistoria
    @Published var historiaFinalizada: Bool = false
    
    @AppStorage("historiasConcluidas") private var historiasConcluidasData: Data = Data()
    private(set) var idsConcluidos: Set<String> = []
    
    private let historia: Historia
    private var mapaDeNos: [String: NoHistoria] = [:]
    
    init(historia: Historia) {
        self.historia = historia
        
        for no in historia.nos {
            mapaDeNos[no.id] = no
        }
        
        guard let primeiroNo = mapaDeNos[historia.noInicial] else {
            fatalError("Nó inicial '\(historia.noInicial)' não encontrado.")
        }
        noAtual = primeiroNo
        
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
            historiasConcluidasData = encoded
        }
    }
    
    private func carregarProgresso() {
        if let decoded = try? JSONDecoder().decode(Set<String>.self, from: historiasConcluidasData) {
            idsConcluidos = decoded
        }
    }
}
