import Foundation
import SwiftUI

struct SelecaoColunas {
    var idPrimeiraColuna: Int?
    var idSegundaColuna: Int?
    
    
    func isValid(tamanho: Int) -> Bool {
        guard let idPrimeiraColuna, let idSegundaColuna else {
            return false
        }
        return idSegundaColuna < tamanho && idPrimeiraColuna < tamanho
    }
    
    mutating func deselecionar() {
        self.idPrimeiraColuna = nil
        self.idSegundaColuna = nil
    }
}

@Observable
class RelacionarColunasViewModel {
    let vetor1: [Int]
    let vetor2: [Int]
    
    let exercicio: Exercicio

    var selecao: SelecaoColunas
    
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
        
        self.selecao = SelecaoColunas()
    }

    func selecionarColuna1(_ i: Int) {
        if desativado[i] { return }
        withAnimation {
            if selecao.idPrimeiraColuna == i {
                selecao.idPrimeiraColuna = nil
            } else {
                selecao.idPrimeiraColuna = i
            }
        }
    }

    func selecionarColuna2(_ i: Int) {
        if desativado[i] { return }
        withAnimation {
            if selecao.idSegundaColuna == i {
                selecao.idSegundaColuna = nil
            } else {
                selecao.idSegundaColuna = i
            }
        }
    }

    func resetar() {
        estadoFeedback = .neutro
        selecao.deselecionar()
    }

    func checkAcerto() async {
        if estadoFeedback != .neutro {
            return
        }

        if (selecao.isValid(tamanho: desativado.count)),
            let selecao1 = selecao.idPrimeiraColuna,
            let selecao2 = selecao.idSegundaColuna {
            let idx1 = vetor1.firstIndex(where: {$0 == selecao1})
            let idx2 = vetor2.firstIndex(where: {$0 == selecao2})
            
            if (idx1 == idx2) {
                withAnimation {
                    desativado[selecao1] = true
                    desativado[selecao2] = true
                }
                selecao.deselecionar()
            }
            else {
                withAnimation {
                    estadoFeedback = .erro
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
