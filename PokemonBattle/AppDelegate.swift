//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import UIKit
import Swinject

let dependencyContainer = Container()

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerDependencies()
        return true
    }
    
    private func registerDependencies() {
        dependencyContainer.register(Commentator.self, factory: { _ in TextCommentator() })
            .inObjectScope(.container)
        dependencyContainer.register(Pokeutil.self, factory: { _ in PokeUtil() })
            .inObjectScope(.container)
        dependencyContainer.register(PokeCenter.self, factory: { _ in PokemonCenter() })
            .inObjectScope(.container)
    }
}

struct StarterPokemon {
    static let scratch = PokemonAttack(
        name: "Scratch",
        damage: 20,
        elementType: .normal
    )
    static let ember = PokemonAttack(
        name: "Ember",
        damage: 30,
        elementType: .fire
    )
    static let tackle = PokemonAttack(
        name: "Tackle",
        damage: 20,
        elementType: .normal
    )
    static let waterGun = PokemonAttack(
        name: "Water Gun",
        damage: 30,
        elementType: .water
    )
    static let leafAttack = PokemonAttack(
        name: "Leaf Attack",
        damage: 25,
        elementType: .grass
    )
    
    static let charmander = Pokemon(
        name: "Charmander",
        type: .fire,
        imageName: "charmander",
        maxHP: 100,
        currentHP: 100,
        speed: 30,
        moves: [scratch, ember]
    )
    static let mudkip = Pokemon(
        name: "Mudkip",
        type: .water,
        imageName: "mudkip",
        maxHP: 120,
        currentHP: 120,
        speed: 35,
        moves: [tackle, waterGun]
    )
    static let bulbasaur = Pokemon(
        name: "Bulbasaur",
        type: .grass,
        imageName: "bulbasaur",
        maxHP: 150,
        currentHP: 150,
        speed: 27,
        moves: [tackle, leafAttack]
    )
}

struct PreviewData {
    static let ash = PokemonTrainer(name: "Ash", pokemons: [StarterPokemon.charmander])
    static let gary = PokemonTrainer(name: "Gary", pokemons: [StarterPokemon.mudkip])
}
