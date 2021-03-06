//
//  Battle.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

struct RoundDetails {
    let attackingPokemon: Pokemon
    let defendingPokemon: Pokemon
}

struct RoundResult {
    let didTrainer1PokemonFaint: Bool
    let didTrainer2PokemonFaint: Bool
}

class Battle {
    // MARK: - Properties
    let trainer1: PokemonTrainer
    let trainer2: PokemonTrainer
    var pokemon1: Pokemon
    var pokemon2: Pokemon
    private var pokemon1MoveID: String?
    private var pokemon2MoveID: String?
    var pokemon1BattleEffects = [BattleEffect]()
    var pokemon2BattleEffects = [BattleEffect]()
    private var fasterPokemon: Pokemon
    
    // MARK: - Dependencies
    @Dependency private var commentator: Commentator
    
    // MARK: - Init
    init(trainer1: PokemonTrainer, trainer2: PokemonTrainer) {
        self.trainer1 = trainer1
        self.trainer2 = trainer2
        
        assert(trainer1.pokemons.isNotEmpty)
        assert(trainer2.pokemons.isNotEmpty)
        
        self.pokemon1 = trainer1.pokemons.first!
        self.pokemon2 = trainer2.pokemons.first!
        self.fasterPokemon = pokemon1.speed >= pokemon2.speed ? pokemon1 : pokemon2
    }
}

extension Battle {
    func setRoundParams(pokemon1MoveID: String, pokemon2MoveID: String) {
        self.pokemon1MoveID = pokemon1MoveID
        self.pokemon2MoveID = pokemon2MoveID
    }
    
    func prepareForRound1() -> RoundDetails {
        fasterPokemon = getFasterPokemon()
        return RoundDetails(
            attackingPokemon: fasterPokemon,
            defendingPokemon: (fasterPokemon == pokemon1) ? pokemon2 : pokemon1
        )
    }
    
    func performRoundStep1()  -> RoundResult {
        if fasterPokemon == pokemon1 {
            return pokemon1Turn()
        } else {
            return pokemon2Turn()
        }
    }
    
    func performRoundStep2() -> RoundResult {
        let roundResult: RoundResult
        if fasterPokemon == pokemon1 {
            roundResult = pokemon2Turn()
        } else {
            roundResult = pokemon1Turn()
        }
        
        return roundResult
    }
    
    private func pokemon1Turn() -> RoundResult {
        guard let pokemon1Move = pokemon1.getMove(withID: pokemon1MoveID!) else { fatalError("Pokemon move not found") }
        
        // Commenting
        var comment = "\(pokemon1.name) used \(pokemon1Move.name)"
        if pokemon1Move is PokemonAttack {
            comment += " on \(pokemon2.name)"
        }
        commentator.comment(comment)
        
        pokemon1.performMove(pokemon1Move, opponent: pokemon2)
        
        return RoundResult(
            didTrainer1PokemonFaint: pokemon1.isFainted,
            didTrainer2PokemonFaint: pokemon2.isFainted
        )
    }
    
    private func pokemon2Turn() -> RoundResult{
        guard let pokemon2Move = pokemon2.getMove(withID: pokemon2MoveID!) else { fatalError("Pokemon move not found") }
        
        // Commenting
        var comment = "\(pokemon2.name) used \(pokemon2Move.name)"
        if pokemon2Move is PokemonAttack {
            comment += " on \(pokemon1.name)"
        }
        commentator.comment(comment)
        
        pokemon2.performMove(pokemon2Move, opponent: pokemon1)

        return RoundResult(
            didTrainer1PokemonFaint: pokemon1.isFainted,
            didTrainer2PokemonFaint: pokemon2.isFainted
        )
    }
}

// MARK: - Util
private extension Battle {
    func getFasterPokemon() -> Pokemon {
        let pokemon1BattleSpeed = pokemon1.battleSpeed(afterApplying: pokemon1BattleEffects)
        let pokemon2BattleSpeed = pokemon2.battleSpeed(afterApplying: pokemon2BattleEffects)
        
        if pokemon1BattleSpeed >= pokemon2BattleSpeed {
            return pokemon1
        } else {
            return pokemon2
        }
    }
}
