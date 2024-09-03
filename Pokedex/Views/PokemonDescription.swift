//
//  PokemonDescription.swift
//  Pokedex
//
//  Created by Armando Meza on 2/13/23.
//

import SwiftUI

struct PokemonDescription: View {
    var infoURL = ""
    @State var description = ""
    @State var pokemonInfo = PokemonInfo(id: 0, name: "", height: 0, weight: 0)
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemonInfo.sprites?.other.officialArtwork.front_default ?? "")) {
                image in
                    image.image?.resizable()
                    .scaledToFit()
            }
            HStack {
                Text("No. \(pokemonInfo.id)")
                Text("\(pokemonInfo.name.capitalized)").font(.largeTitle)
            }
            HStack {
                Text("\(description)").font(.subheadline).padding(18).fontWeight(.medium)
                VStack {
                    let height = String(format: "%.2f", Double(pokemonInfo.height) / 10)
                    let weight = String(format: "%.2f", Double(pokemonInfo.weight) / 10)

                    Text("Height \(height)m")
                    Text("Weight \(weight)kgs")
                    HStack {
                        ForEach(getTypes(pokemonTypes: pokemonInfo.types), id: \.self) {
                            entry in
                                HStack {
                                    PokemonTypeBadge(type: entry)
                                }
                            }
                    }.padding(.horizontal, 15)
                }
            }
        }
        .onAppear {
            PokeApi().getPokemonInfo(url: infoURL) { pokeInfo in
                self.pokemonInfo = pokeInfo
                
                PokeApi().getPokemonDescriptionText(id: pokemonInfo.id) { pokeDescription in
                    self.description = pokeDescription
                }
            }
        }

//        HStack {
//            VStack {
////                CacheableImage(url: pokemonInfo.sprites?.front_default ?? "")
////                    .frame(width: 96, height: 96)
//                CacheableImage(url: pokemonInfo.sprites?.other.officialArtwork.front_default ?? "")
//                    .frame(width: 96, height: 96)
//                Text("No. \(pokemonInfo.id)")
//                ForEach(getTypes(pokemonTypes: pokemonInfo.types), id: \.self) {
//                    entry in
//                        HStack {
//                            PokemonTypeBadge(type: entry)
//                        }
//                    }
//                
//            }
//            VStack {
//                let height = String(format: "%.2f", Double(pokemonInfo.height) / 10)
//                let weight = String(format: "%.2f", Double(pokemonInfo.weight) / 10)
//                
//                Text("\(pokemonInfo.name.capitalized)").font(.title)
//                Text("")
//                Text("Height \(height)m")
//                Text("Weight \(weight)kgs")
//                Text("\(description)").padding(10)
//            }
//        }
//            .onAppear {
//                PokeApi().getPokemonInfo(url: infoURL) { pokeInfo in
//                    self.pokemonInfo = pokeInfo
//                    
//                    PokeApi().getPokemonDescriptionText(id: pokemonInfo.id) { pokeDescription in
//                        self.description = pokeDescription
//                    }
//                }
//            }
    }
    
    func getTypes(pokemonTypes: [PokemonTypeInfo]?) -> [String] {
        guard let typesList = pokemonTypes else { return [] }
        return typesList.map { $0.type.name }
    }
}

struct PokemonDescription_Previews: PreviewProvider {
    static var previews: some View {
        let fireType = PokemonType(name: "electric")
        let fireTypesInfo = PokemonTypeInfo(type: fireType)
        let flyringType = PokemonType(name: "fighting")
        let flyingTypesInfo = PokemonTypeInfo(type: flyringType)
        
        let description = "Breathing intense,\nhot flames, it can \nmelt almost any­thing. \nIts breath inflicts terrible \npain on enemies."
        
        let officialArtwork = OfficialArtworkImg(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png")
        let otherPkmnSprites = OtherPokemonSprites(officialArtwork: officialArtwork)
        let sprites = PokemonSprites(front_default: "", other: otherPkmnSprites)
        let pkmnInfo = PokemonInfo(id: 6, name: "Charizard", height: 17, weight: 905, sprites: sprites, types: [fireTypesInfo, flyingTypesInfo])
        
        PokemonDescription(infoURL: "", description: description, pokemonInfo: pkmnInfo)
    }
}
