//
//  PokemonDescription.swift
//  Pokedex
//
//  Created by Armando Meza on 2/13/23.
//

import SwiftUI

struct PokemonDescription: View {
    var infoURL = ""
    @State var pokemonInfo = PokemonDescriptionInfo(id: 0, name: "")
    
    var body: some View {
        HStack {
            Text("\(pokemonInfo.name.capitalized) is pokemon #\(pokemonInfo.id)")
                .navigationTitle(pokemonInfo.name.capitalized)
        }
            .onAppear {
                PokeApi().getDescription(url: infoURL) { pokeInfo in
                    self.pokemonInfo = pokeInfo
                }
            }
    }
}

struct PokemonDescription_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescription()
    }
}
