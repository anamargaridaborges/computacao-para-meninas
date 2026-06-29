//
//  MultiplaEscolhaViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import Foundation
import SwiftUI

@MainActor
class MultiplaEscolhaViewModel: ObservableObject {

    let idExercicio: Int
    let resposta: Int
    let codigo: String
    let mensagemErro: String = "Para realizar uma soma com num1, preciso que essa variável armazene um inteiro."

    @Published var idSelecionado: Int = -1
    @Published var botaoAtivo: Bool = false
    @Published var estadoFeedback: EstadoFeedback = .neutro

    init(idExercicio: Int, resposta: Int, codigo: String) {
        self.idExercicio = idExercicio
        self.resposta = resposta
        self.codigo = codigo
    }

    func selecionar(_ i: Int) {
        idSelecionado = i
        botaoAtivo = true
    }

    func verificar() {
        estadoFeedback = (idSelecionado == resposta) ? .acerto : .erro
    }

    func resetar() {
        estadoFeedback = .neutro
        idSelecionado = -1
    }
}
