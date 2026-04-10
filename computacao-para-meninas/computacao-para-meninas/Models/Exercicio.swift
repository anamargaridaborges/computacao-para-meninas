//
//  Exercicio.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

enum TipoExercicio: Decodable {
    case tipo3([Int], [Int])

    enum CodingKeys: String, CodingKey {
        case tipo
        case valores1
        case valores2
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tipo = try container.decode(String.self, forKey: .tipo)

        switch tipo {
        case "tipo3":
            let v1 = try container.decode([Int].self, forKey: .valores1)
            let v2 = try container.decode([Int].self, forKey: .valores2)
            self = .tipo3(v1, v2)
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
