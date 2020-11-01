//
//  PokemonTrainer.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

class PokemonTrainer {
    // MARK: - Properties
    var name: String
    @CountConstrained(maxCount: MaxNumberOfPokemon) var pokemons: [Pokemon]
    var battleWins = 0
    var battleLosses = 0
    
    // MARK: - Init
    init(name: String, pokemons: [Pokemon] = []) {
        self.name = name
        self.pokemons = pokemons
    }
}
