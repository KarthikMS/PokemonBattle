//
//  PokeCenter.swift
//  PokemonBattle
//
//  Created by Karthik on 14/02/21.
//

protocol PokeCenter {
    func heal(_ pokemon: Pokemon)
    func heal(_ pokemons: [Pokemon])
}

final class PokemonCenter: PokeCenter {
    func heal(_ pokemon: Pokemon) {
        heal([pokemon])
    }
    
    func heal(_ pokemons: [Pokemon]) {
        pokemons.forEach { $0.currentHP = $0.maxHP }
    }
}
