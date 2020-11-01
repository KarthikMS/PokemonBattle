//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        testBattle()
        return true
    }
    
    func testBattle() {
        let scratch = PokemonAttack(
            damage: 20,
            elementType: .normal
        )
        let ember = PokemonAttack(
            damage: 30,
            elementType: .fire
        )
        let tackle = PokemonAttack(
            damage: 20,
            elementType: .normal
        )
        let waterGun = PokemonAttack(
            damage: 30,
            elementType: .water
        )
        
        let charmander = Pokemon(
            name: "Charmander",
            type: .fire,
            maxHP: 100,
            currentHP: 100,
            speed: 30,
            moves: [scratch, ember]
        )
        let mudkip = Pokemon(
            name: "Mudkip",
            type: .water,
            maxHP: 120,
            currentHP: 120,
            speed: 35,
            moves: [tackle, waterGun]
        )
        
        let ash = PokemonTrainer(name: "Ash", pokemons: [charmander])
        let gary = PokemonTrainer(name: "Gary", pokemons: [mudkip])
        
        let battle = Battle(trainer1: ash, trainer2: gary)
        let pokemon1 = ash.pokemons[0]
        let pokemon2 = gary.pokemons[0]
        
        func printHealth() {
            print("\n\(ash.pokemons[0].name): \(ash.pokemons[0].currentHP) / \(ash.pokemons[0].maxHP)")
            print("\(pokemon2.name): \(pokemon2.currentHP) / \(pokemon2.maxHP)")
        }
        
        print("Battle between: \(pokemon1.name) and \(pokemon2.name)")
        printHealth()
        
        // Round 1
        battle.setRoundParams(pokemon1MoveID: scratch.id, pokemon2MoveID: tackle.id)
        battle.performRoundStep1()
        battle.performRoundStep2()
        printHealth()
        
        // Round 2
        battle.setRoundParams(pokemon1MoveID: scratch.id, pokemon2MoveID: tackle.id)
        battle.performRoundStep1()
        battle.performRoundStep2()
        printHealth()
        
        // Round 3
        battle.setRoundParams(pokemon1MoveID: scratch.id, pokemon2MoveID: tackle.id)
        battle.performRoundStep1()
        battle.performRoundStep2()
        printHealth()
        
        // Round 4
        battle.setRoundParams(pokemon1MoveID: scratch.id, pokemon2MoveID: waterGun.id)
        battle.performRoundStep1()
        battle.performRoundStep2()
        printHealth()
    }
    
    
}
