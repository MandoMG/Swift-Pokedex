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

struct PokemonInfo: Codable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var sprites: PokemonSprites?
    var types: [PokemonTypeInfo]?
}

struct PokemonSprites: Codable {
    var front_default: String
    var other: OtherPokemonSprites
        
}

struct OtherPokemonSprites: Codable {
    var officialArtwork: OfficialArtworkImg
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }

}

struct OfficialArtworkImg: Codable {
    var front_default: String
}

struct PokemonTypeInfo: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
}

struct PokemonEntry: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

struct PokemonSpeciesInfo: Codable {
    var flavor_text_entries: [PokemonFlavorTextEntry]
}

struct PokemonFlavorTextEntry: Codable {
    var flavor_text: String
    var language: PokemonInfoNameUrl
    var version: PokemonInfoNameUrl
}

struct PokemonInfoNameUrl: Codable {
    var name: String
    var url: String
}

class PokeApi {
    func getData(completion: @escaping (([PokemonEntry]) -> ())) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=251") else {
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
    

    func getPokemonDescriptionText(id: Int, completion: @escaping ((String) -> ())) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonSpeciesInfo = try! JSONDecoder().decode(PokemonSpeciesInfo.self, from: data)
            
            let filteredText = pokemonSpeciesInfo.flavor_text_entries.filter { $0.version.name == "silver" && $0.language.name == "en" }
            
            DispatchQueue.main.async {
                completion(filteredText[0].flavor_text)
            }
        }.resume()
    }
    
    func getPokemonInfo(url: String, completion: @escaping ((PokemonInfo) -> ())) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonInfo = try! JSONDecoder().decode(PokemonInfo.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonInfo)
            }
        }.resume()
    }
    
    func getSprites(url: String, completion: @escaping ((PokemonSprites) -> ())) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }.resume()
    }
}
