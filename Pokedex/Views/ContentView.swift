//
//  ContentView.swift
//  Pokedex
//
//  Created by Armando Meza on 2/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter({
                    $0.name.contains(searchText.lowercased())
                })) {
                    entry in
                    HStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(entry.name)".capitalized,
                                       destination: PokemonDescription(infoURL: entry.url))
                    }
                }
            }
            .onAppear {
                PokeApi().getData() { pokemonList in
                    self.pokemon = pokemonList
                }
            }
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .navigationTitle("Pokedex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
