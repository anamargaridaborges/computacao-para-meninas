import XCTest
@testable import computacao_para_meninas

final class TipoExercicioDecodingTests: XCTestCase {

    private func decodeTipo(from json: [String: Any]) throws -> TipoExercicio {
        let data = try JSONSerialization.data(withJSONObject: json)
        let decoder = JSONDecoder()
        struct Wrapper: Decodable { let tipo: TipoExercicio }
        return try decoder.decode(Wrapper.self, from: data).tipo
    }

    func testEquivalenceClasses_knownTiposDecode() throws {
        // conteudoTeorico
        let t1 = try decodeTipo(from: [
            "tipo": "conteudoTeorico",
            "texto": "abc",
            "imagem": NSNull(),
            "dica": NSNull()
        ])
        if case .conteudoTeorico(let texto, let imagem, let dica) = t1 {
            XCTAssertEqual(texto, "abc")
            XCTAssertNil(imagem)
            XCTAssertNil(dica)
        } else { XCTFail("Mapeamento errado para conteudoTeorico") }

        // multiplaEscolha
        let t2 = try decodeTipo(from: [
            "tipo": "multiplaEscolha",
            "resposta": 1,
            "codigo": "print(1)"
        ])
        if case .multiplaEscolha(let r, let c) = t2 {
            XCTAssertEqual(r, 1)
            XCTAssertEqual(c, "print(1)")
        } else { XCTFail("Mapeamento errado para multiplaEscolha") }

        // ordenar
        let t3 = try decodeTipo(from: [
            "tipo": "ordenar",
            "linhas": ["a", "b"]
        ])
        if case .ordenar(let linhas) = t3 {
            XCTAssertEqual(linhas, ["a", "b"])
        } else { XCTFail("Mapeamento errado para ordenar") }

        // relacionarColunas
        let t4 = try decodeTipo(from: [
            "tipo": "relacionarColunas",
            "valores1": [0,1],
            "valores2": [1,0]
        ])
        if case .relacionarColunas(let v1, let v2) = t4 {
            XCTAssertEqual(v1, [0,1])
            XCTAssertEqual(v2, [1,0])
        } else { XCTFail("Mapeamento errado para relacionarColunas") }

        // curiosidade
        let t5 = try decodeTipo(from: [
            "tipo": "curiosidade",
            "conteudo": "xyz"
        ])
        if case .curiosidade(let conteudo) = t5 {
            XCTAssertEqual(conteudo, "xyz")
        } else { XCTFail("Mapeamento errado para curiosidade") }
    }

    func testBoundary_unknownTipoFails() {
        let json: [String: Any] = ["tipo": "desconhecido"]
        XCTAssertThrowsError(try decodeTipo(from: json)) { error in
            guard case DecodingError.dataCorrupted = error else {
                XCTFail("Esperava DecodingError.dataCorrupted, recebeu: \(error)")
                return
            }
        }
    }
}
