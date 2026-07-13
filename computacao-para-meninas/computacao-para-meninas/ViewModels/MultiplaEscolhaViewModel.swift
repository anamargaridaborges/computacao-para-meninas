import Foundation
import SwiftUI

@Observable
class MultiplaEscolhaViewModel {
    let exercicio: Exercicio
    
    let resposta: Int
    let codigo: String?

    let onConcluirAtividade: () -> Void

    var idSelecionado: Int = -1
    var botaoAtivo: Bool = false
    var estadoFeedback: EstadoFeedback = .neutro

    init(resposta: Int, codigo: String, exercicio: Exercicio, onConcluirAtividade: @escaping () -> Void) {
        self.resposta = resposta
        self.codigo = codigo
        self.onConcluirAtividade = onConcluirAtividade
        
        guard case .multiplaEscolha = exercicio.tipo else {
            fatalError("MultiplaEscolhaViewModel necessita de um exercício do tipo .multiplaEscolha")
        }
        self.exercicio = exercicio
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
