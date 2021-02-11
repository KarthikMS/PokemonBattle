//
//  Pokemon.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

class Pokemon: ObservableObject {
    // MARK: - Properties
    let id = UUID().uuidString
    var name: String
    var type: ElementType
    let imageName: String
    @LowerLimit(0) var maxHP: Int
    @Published var currentHP: Int = 0 {
        didSet {
            if currentHP < 0 {
                currentHP = 0
            }
        }
    }
    @LowerLimit(1) var speed: Int
    @MaxCount(MaxNumberOfPokemonMoves) var moves: [PokemonMove]
    
    // MARK: - Init
    init(name: String, type: ElementType, imageName: String, maxHP: Int, currentHP: Int, speed: Int, moves: [PokemonMove]) {
        self.name = name
        self.type = type
        self.imageName = imageName
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

// MARK: - Identifiable
extension Pokemon: Identifiable {}

// MARK: - Util
extension Pokemon {
    var isFainted: Bool { currentHP == 0 }
    
    func getMove(withID moveID: String) -> PokemonMove? {
        moves.first(where: { $0.id == moveID })
    }
}
