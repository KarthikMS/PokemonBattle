//
//  PokemonSelectionViewModel.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

final class PokemonSelectionViewModel: ObservableObject {
    var pokemons = [
        StarterPokemon.charmander,
        StarterPokemon.mudkip,
        StarterPokemon.bulbasaur
    ]
    
    func getPokemonTrainerWithPokemon(_ pokemon: Pokemon) -> PokemonTrainer {
        PokemonTrainer(name: "Ash", pokemons: [pokemon])
    }
    
    func getPokemonTrainerWithPokemonOtherThan(_ pokemon: Pokemon) -> PokemonTrainer {
        let trainerPokemon = pokemons
            .filter { $0 != pokemon }
            .randomElement()!
        return PokemonTrainer(name: "Gary", pokemons: [trainerPokemon])
    }
}
