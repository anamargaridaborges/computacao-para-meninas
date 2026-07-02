//
//  ExercicioTeoricoViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 25/06/26.
//

import Foundation
import SwiftUI

@Observable
class ExercicioTeoricoViewModel {
    let texto: String
    let imagem: String?
    let dica: String?
    let enunciado: String
    let exercicio: Exercicio
    
    let onConcluirAtividade: () -> Void

    init(exercicio: Exercicio, texto: String, imagem: String?, dica: String?, onConcluirAtividade: @escaping () -> Void) {
        self.texto = texto
        self.imagem = imagem
        self.dica = dica
        self.enunciado = exercicio.enunciado
        self.exercicio = exercicio
        self.onConcluirAtividade = onConcluirAtividade
    }

    var imagemValida: String? {
        guard let imagem, !imagem.isEmpty else { return nil }
        return imagem
    }

    var dicaValida: String? {
        guard let dica, !dica.isEmpty else { return nil }
        return dica
    }
}
