//
//  Pokemon.swift
//  Pokedex
//
//  Created by Armando Meza on 2/12/23.
//

import Foundation

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonDescriptionInfo: Codable {
    var id: Int
    var name: String
}

struct PokemonEntry: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi {
    func getData(completion: @escaping (([PokemonEntry]) -> ())) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
    
    func getDescription(url: String, completion: @escaping ((PokemonDescriptionInfo) -> ())) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonDescription = try! JSONDecoder().decode(PokemonDescriptionInfo.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonDescription)
            }
        }.resume()
    }
}
