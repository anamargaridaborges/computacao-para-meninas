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
    /// Nome do asset no Assets.xcassets (capa/retrato da personagem)
    let imagem: String
    /// Parágrafos da história/bio, exibidos na tela de detalhe
    let historia: [String]
    let pontosNecessarios: Int

    func estaDesbloqueada(pontosTotais: Int) -> Bool {
        pontosTotais >= pontosNecessarios
    }
}