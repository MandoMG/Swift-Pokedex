//
//  PokemonShortcuts.swift
//  Pokedex
//
//  Created by Armando Meza on 9/13/24.


import Foundation
import AppIntents

struct PokemonShortcuts: AppShortcutsProvider {
    static var shortcutTileColor = ShortcutTileColor.blue
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: PokemonIntent(), phrases: ["Show Charizard Description"], shortTitle: "Show Pokemon Description")
    }
}
