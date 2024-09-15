//
//  PokemonIntent.swift
//  Pokedex
//
//  Created by Armando Meza on 9/13/24.
//

import Foundation
import AppIntents
import SwiftUI

struct PokemonIntent: AppIntent {
    static var title = LocalizedStringResource("Show Charizard")
    static var description = IntentDescription("Shows Description for Charizard")
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "Pokemon Name", description: "The pokemon to get information on.")
    var pokemonTitle: String
    
    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        print("Shows \(pokemonTitle) info")
        let dialog = IntentDialog(full: "Here's some information about \(pokemonTitle)", supporting: "Here's some information about \(pokemonTitle)")
        
        return .result(value: pokemonTitle, dialog: dialog)
    }
}
