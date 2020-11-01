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
    @LowerLimit(1) var speed: Int
    @MaxCount(MaxNumberOfPokemonMoves) var moves: [PokemonMove]
    
    // MARK: - Init
    init(name: String, type: ElementType, maxHP: Int, currentHP: Int, speed: Int, moves: [PokemonMove]) {
        self.name = name
        self.type = type
        self.maxHP = maxHP
        self.currentHP = currentHP
        self.speed = speed
        self.moves = moves
    }
}

// MARK: - Equatable
extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Util
extension Pokemon {
    var isFainted: Bool { currentHP == 0 }
}
