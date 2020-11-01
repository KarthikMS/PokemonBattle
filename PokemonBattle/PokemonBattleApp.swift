//
//  PokemonBattleApp.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

@main
struct PokemonBattleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BattlePokemonDetailsView(
                viewModel: BattlePokemonDetailsViewModel(
                    pokemon: Pokemon(
                        name: "Charmander",
                        type: .fire,
                        maxHP: 100,
                        currentHP: 80,
                        speed: 30,
                        moves: []
                    )
                )
            )
        }
    }
}
