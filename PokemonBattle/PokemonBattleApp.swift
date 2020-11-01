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
            BattleMainMenu(
                viewModel: BattleViewModel(
                    trainer1: PreviewData.ash,
                    trainer2: PreviewData.gary
                )
            )
        }
    }
}
