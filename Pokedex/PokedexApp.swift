//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Armando Meza on 2/12/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    init () {
        PokemonShortcuts.updateAppShortcutParameters()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
