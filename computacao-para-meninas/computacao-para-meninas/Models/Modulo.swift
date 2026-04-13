//
//  Modulo.swift
//  computacao-para-meninas
//
//  Created by Ana Macedo on 12/04/26.
//

import Foundation

struct Modulo: Identifiable, Codable {
    var id: UUID = UUID()
    var nome: String
    var atividades: [Atividade]
}
