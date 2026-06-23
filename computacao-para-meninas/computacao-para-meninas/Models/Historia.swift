//
//  Historia.swift
//  computacao-para-meninas
//
//  Created by Lara Matias Pasquotti on 22/06/26.
//

import Foundation

enum TipoNo: String, Codable {
    case dialogo
    case escolha
    case fim
}

struct Escolha: Codable, Identifiable {
    var id: String
    var texto: String
    var proximoNo: String
}

struct NoHistoria: Codable, Identifiable {
    var id: String
    var tipo: TipoNo
    var fala: String?
    var escolhas: [Escolha]?
    var proximoNo: String?
    var mensagemFinal: String?
}

struct Historia: Codable, Identifiable {
    var id: String
    var titulo: String
    var noInicial: String
    var nos: [NoHistoria]
}

func carregarHistoria(_ filename: String) -> Historia {
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Arquivo \(filename) não encontrado no bundle.")
    }
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Historia.self, from: data)
    } catch {
        fatalError("Erro ao ler o arquivo \(filename): \(error)")
    }
}
