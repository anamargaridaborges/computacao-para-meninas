//
//  ExercicioTeoricoViewModel.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 25/06/26.
//

import Foundation
import SwiftUI

@MainActor
class ExercicioTeoricoViewModel: ObservableObject {

    let idExercicio: Int
    let texto: String
    let imagem: String?
    let dica: String?

    init(idExercicio: Int, texto: String, imagem: String?, dica: String?) {
        self.idExercicio = idExercicio
        self.texto = texto
        self.imagem = imagem
        self.dica = dica
    }

    var enunciado: String {
        exercicios[idExercicio].enunciado
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
