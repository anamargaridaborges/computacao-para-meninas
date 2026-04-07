//
//  Exercicio.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

enum TipoExercicio: Decodable {
    case tipo3([Int], [Int])
}

struct Exercicio: Decodable {
    var tipo: TipoExercicio
    var enunciado: String
    var alternativas: [String]
    var explicacao: String
}
