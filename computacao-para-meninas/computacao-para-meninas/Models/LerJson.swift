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
/// Tries to load and decode a JSON file if it exists. Returns nil if the file
/// isn't found or if decoding fails.
func loadIfPresent<T: Decodable>(_ filename: String) -> T? {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        return nil
    }
    do {
        let data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Failed to load \(filename): \(error)")
        return nil
    }
}

/// Loads exercises for a specific activity id from a file named
/// "Exercicios_<idAtividade>.json" if present. Example: "Exercicios_atv_1.json".
@MainActor
func loadExercisesForActivity(idAtividade: String) -> [Exercicio]? {
    let filename = "Exercicios_\(idAtividade).json"
    return loadIfPresent(filename)
}

