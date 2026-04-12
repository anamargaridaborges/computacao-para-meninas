//
//  TrilhaViewModel.swift
//  
//
//  Created by Ana Macedo on 12/04/26.
//

import Foundation
import SwiftUI

class TrilhaViewModel: ObservableObject {
    @AppStorage("atividadesConcluidas") var atividadesConcluidasData: Data = Data()
    @Published var idsConcluidos: Set<String> = []

    init() {
        loadProgress()
    }

    // carrega o progresso salvo
    func loadProgress() {
        if let decoded = try? JSONDecoder().decode(Set<String>.self, from: atividadesConcluidasData) {
            idsConcluidos = decoded
        }
    }

    // salva o progresso da usuario
    func saveProgress() {
        if let encoded = try? JSONEncoder().encode(idsConcluidos) {
            atividadesConcluidasData = encoded
        }
    }

    func estaDesbloqueada(idAtividade: String, idDependencia: String?) -> Bool {
        guard let dependencia = idDependencia else { return true }
        return idsConcluidos.contains(dependencia)
    }

    func concluirAtividade(id: String) {
        idsConcluidos.insert(id)
        saveProgress()
    }
}
