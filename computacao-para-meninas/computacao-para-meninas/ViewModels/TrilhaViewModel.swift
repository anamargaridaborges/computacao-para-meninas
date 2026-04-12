//
//  TrilhaViewModel.swift
//  
//
//  Created by Ana Macedo on 12/04/26.
//

import SwiftUI

class TrilhaViewModel: ObservableObject {
    @AppStorage("nivelProgresso") var nivelProgresso: Int = 0
    let exerciciosIds: [Int] = [0, 1, 2, 3]
    
    func estaDesbloqueado(index: Int) -> Bool {
        return index <= nivelProgresso
    }
    
    func concluirExercicio(atual: Int) {
        if atual == nivelProgresso {
            nivelProgresso += 1
        }
    }
}
