//
//  PkmnTypeBadge.swift
//  Pokedex
//
//  Created by Armando Meza on 8/29/24.
//

import SwiftUI

struct PokemonTypeBadge: View {
    var type = "dark"
    
    var body: some View {
        VStack {
            HStack {
                Text("\(type)")
                    .padding(10)
                    .colorInvert()
            }
            .background(getColor())
            .cornerRadius(10)
        }
    }
    
    func getColor() -> Color {
        switch(type) {
        case "normal", "steel":
            return Color.gray.opacity(0.80)
        case "fighting", "psychic", "fairy":
            return Color.pink.opacity(0.80)
        case "water", "flying", "dragon":
            return Color.blue.opacity(0.80)
        case "poison", "ghost":
            return Color.purple.opacity(0.80)
        case "ground":
            return Color.brown.opacity(0.80)
        case "rock":
            return Color.brown.opacity(0.50)
        case "grass", "bug":
            return Color.green.opacity(0.8)
        case "fire":
            return Color.red.opacity(0.80)
        case "electric":
            return Color.yellow.opacity(0.80)
        case "ice":
            return Color.blue.opacity(0.60)
        case "dark":
            return Color.black.opacity(0.70)
        default:
            return Color.gray.opacity(0.80)
        }
    }
}

struct PokemonTypeBadge_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeBadge()
    }
}
