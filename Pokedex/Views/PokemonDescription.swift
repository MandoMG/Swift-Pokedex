//
//  PokemonDescription.swift
//  Pokedex
//
//  Created by Armando Meza on 2/13/23.
//

import SwiftUI

struct PokemonDescription: View {
    var infoURL = ""
    @State var pokemonInfo = PokemonInfo(id: 0, name: "", height: 0, weight: 0)
    
    var body: some View {
        HStack {
            VStack {
                CacheableImage(url: pokemonInfo.sprites?.front_default ?? "")
                Text("No. \(pokemonInfo.id)")
                ForEach(getTypes(pokemonTypes: pokemonInfo.types), id: \.self) {
                    entry in
                        HStack {
                            Text("\(entry)")
                        }
                    }
                
            }
            VStack {
                let height = String(format: "%.2f", Double(pokemonInfo.height) / 10)
                let weight = String(format: "%.2f", Double(pokemonInfo.weight) / 10)
                Text("\(pokemonInfo.name.capitalized)").font(.title)
                Text("")
                Text("Height \(height)m")
                Text("Weight \(weight)kgs")
            }
        }
            .onAppear {
                PokeApi().getPokemonInfo(url: infoURL) { pokeInfo in
                    self.pokemonInfo = pokeInfo
                }
            }
    }
    
    func getTypes(pokemonTypes: [PokemonTypeInfo]?) -> [String] {
        guard let typesList = pokemonTypes else { return [] }
        return typesList.map { $0.type.name }
    }
}

struct PokemonDescription_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescription()
    }
}
