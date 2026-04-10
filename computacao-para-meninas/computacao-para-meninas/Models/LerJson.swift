//
//  LerJson.swift
//  computacao-para-meninas
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import Foundation

@MainActor var exercicios: [Exercicio] = load("LerExercicios.json")

func load<T: Decodable>(_ filename: String) -> T {

        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {

                fatalError("Couldn't find \(filename) in main bundle.")

        }

        do {
                data = try Data(contentsOf: file)
        } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }



        do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
        } catch {
                print(error)
                fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
}
