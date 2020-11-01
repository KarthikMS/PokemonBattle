//
//  Pokemon.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Foundation

class Pokemon {
    // MARK: - Properties
    let id = UUID().uuidString
    var name: String
    var type: ElementType
    @LowerLimit(0) var maxHP: Int
    @LowerLimit(0) var currentHP: Int
    @MaxCount(MaxNumberOfPokemonMoves) var moves: [PokemonMove]
    
    // MARK: - Init
    init(name: String, type: ElementType, maxHP: Int, currentHP: Int, moves: [PokemonMove]) {
        self.name = name
        self.type = type
        self.maxHP = maxHP
        self.currentHP = currentHP
        self.moves = moves
    }
}

// MARK: - Util
extension Pokemon {
    var isFainted: Bool { currentHP == 0 }
}
