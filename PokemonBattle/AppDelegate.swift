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
    }
}

struct PreviewData {
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
    
    static let ash = PokemonTrainer(name: "Ash", pokemons: [charmander])
    static let gary = PokemonTrainer(name: "Gary", pokemons: [mudkip])
}
