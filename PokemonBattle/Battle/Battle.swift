//
//  Battle.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

struct RoundResult {
    let didTrainer1PokemonFaint: Bool
    let didTrainer2PokemonFaint: Bool
}

class Battle {
    // MARK: - Properties
    let trainer1: PokemonTrainer
    let trainer2: PokemonTrainer
    var currentTrainer1Pokemon: Pokemon
    var currentTrainer2Pokemon: Pokemon
    var pokemon1MoveID: String?
    var pokemon2MoveID: String?
    
    // MARK: - Init
    init(trainer1: PokemonTrainer, trainer2: PokemonTrainer) {
        self.trainer1 = trainer1
        self.trainer2 = trainer2
        
        assert(trainer1.pokemons.isNotEmpty)
        assert(trainer2.pokemons.isNotEmpty)
        
        self.currentTrainer1Pokemon = trainer1.pokemons.first!
        self.currentTrainer2Pokemon = trainer2.pokemons.first!
    }
}

extension Battle {
    func setRoundParams(pokemon1MoveID: String, pokemon2MoveID: String) {
        self.pokemon1MoveID = pokemon1MoveID
        self.pokemon2MoveID = pokemon2MoveID
    }
    
    func performRoundStep1()  -> RoundResult {
        guard let pokemon1Move = currentTrainer1Pokemon.moves.first(where: { $0.id == pokemon1MoveID }) else { fatalError("Pokemon move not found") }
        
        currentTrainer1Pokemon.performMove(pokemon1Move, opponent: currentTrainer2Pokemon)
        
        return RoundResult(
            didTrainer1PokemonFaint: currentTrainer1Pokemon.isFainted,
            didTrainer2PokemonFaint: currentTrainer2Pokemon.isFainted
        )
    }
    
    func performRoundStep2() -> RoundResult {
        guard let pokemon2Move = currentTrainer2Pokemon.moves.first(where: { $0.id == pokemon2MoveID }) else { fatalError("Pokemon move not found") }
        
        currentTrainer2Pokemon.performMove(pokemon2Move, opponent: currentTrainer1Pokemon)

        return RoundResult(
            didTrainer1PokemonFaint: currentTrainer1Pokemon.isFainted,
            didTrainer2PokemonFaint: currentTrainer2Pokemon.isFainted
        )
    }
}
