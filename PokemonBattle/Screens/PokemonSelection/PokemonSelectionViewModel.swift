//
//  PokemonSelectionViewModel.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

final class PokemonSelectionViewModel: ObservableObject {
    var pokemons = [
        PreviewData.charmander,
        PreviewData.mudkip
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
