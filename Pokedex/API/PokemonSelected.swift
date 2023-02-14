//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Armando Meza on 2/12/23.
//

import Foundation

struct PokemonSelected: Codable {
    var sprites: PokemonSprites
}

class PokemonSelectedApi {
    func getData(url: String, completion: @escaping ((PokemonSprites) -> ())) {
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
