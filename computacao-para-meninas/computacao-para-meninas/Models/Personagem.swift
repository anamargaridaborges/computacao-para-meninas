//
//  Personagem.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 11/07/26.
//

import Foundation

struct Personagem: Identifiable {
    let id: String
    let nome: String
    let imagem: String
    let historia: [String]
    let pontosNecessarios: Int

    func estaDesbloqueada(pontosTotais: Int) -> Bool {
        pontosTotais >= pontosNecessarios
    }
}
