//
//  PokemonMove.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Foundation


class PokemonMove {
    let id = UUID().uuidString
}

class PokemonAttack: PokemonMove {
    let damage: Int
    let elementType: ElementType
    
    init(damage: Int, elementType: ElementType) {
        self.damage = damage
        self.elementType = elementType
    }
}
