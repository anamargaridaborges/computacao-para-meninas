//
//  Exercicio.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

enum TipoExercicio: Decodable {
    case relacionarColunas([Int], [Int])
    case ordenar([String])
    case tipo1(Int, String)
    case curiosidade(String)
    case conteudoTeorico(texto: String, imagem: String?, dica: String?)

    enum CodingKeys: String, CodingKey {
        case tipo
        case valores1
        case valores2
        case linhas
        case resposta
        case codigo
        case conteudo
        case texto
        case imagem
        case dica
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tipo = try container.decode(String.self, forKey: .tipo)

        switch tipo {
        case "relacionarColunas":
            let v1 = try container.decode([Int].self, forKey: .valores1)
            let v2 = try container.decode([Int].self, forKey: .valores2)
            self = .relacionarColunas(v1, v2)
        case "ordenar":
            let v1 = try container.decode([String].self, forKey: .linhas)
            self = .ordenar(v1)
        case "tipo1":
            let v1 = try container.decode(Int.self, forKey: .resposta)
            let v2 = try container.decode(String.self, forKey: .codigo)
            self = .tipo1(v1, v2)
        case "curiosidade":
            let conteudo = try container.decode(String.self, forKey: .conteudo)
            self = .curiosidade(conteudo)
        case "conteudoTeorico":
            let texto = try container.decode(String.self, forKey: .texto)
            let imagem = try container.decodeIfPresent(String.self, forKey: .imagem)
            let dica = try container.decodeIfPresent(String.self, forKey: .dica)
            self = .conteudoTeorico(texto: texto, imagem: imagem, dica: dica)
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .tipo,
                in: container,
                debugDescription: "Tipo desconhecido: \(tipo)"
            )
        }
    }
}

struct Exercicio: Decodable {
    var tipo: TipoExercicio
    var enunciado: String
    var alternativas: [String]
    var explicacao: String
}
