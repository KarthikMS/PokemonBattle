//
//  PokemonMove.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Foundation


class PokemonMove {
    let id = UUID().uuidString
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class PokemonAttack: PokemonMove {
    let damage: Int
    let elementType: ElementType
    
    init(name: String, damage: Int, elementType: ElementType) {
        self.damage = damage
        self.elementType = elementType
        super.init(name: name)
    }
}
