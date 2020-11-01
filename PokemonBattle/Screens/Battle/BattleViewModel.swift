//
//  BattleViewModel.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

final class BattleViewModel: ObservableObject {
    // MARK: - Properties
    private let trainer1: PokemonTrainer
    private let trainer2: PokemonTrainer
    private let isOpponentAI = true
    
    // TODO: Check if changes need to be tracked.
    var pokemon1: Pokemon { battle.pokemon1 }
    var pokemon2: Pokemon { battle.pokemon2 }
    
    // MARK: - Published
    @Published var menuMode: BattleMainMenu.Mode = .main
    @Published var commentary = ""
    
    // MARK: - Dependencies
    private let battle: Battle
    @Dependency private var commentator: Commentator
    
    // MARK: - Init
    init(trainer1: PokemonTrainer, trainer2: PokemonTrainer) {
        self.trainer1 = trainer1
        self.trainer2 = trainer2
        self.battle = Battle(trainer1: trainer1, trainer2: trainer2)
        
        listenToCommentator()
    }
}

// MARK: - Setup
private extension BattleViewModel {
    func listenToCommentator() {
        commentator.commentStream
            .assign(to: &$commentary)
    }
}

// MARK: - View Inputs
extension BattleViewModel {
    func performAttack(withID attackID: String) {
        menuMode = .attackAnimation
        
        // TODO: Create AIPokemonTrainer.
        if isOpponentAI {
            
        }
        let pokemon2MoveID = battle.pokemon2.randomMove.id
        
        battle.setRoundParams(
            pokemon1MoveID: attackID,
            pokemon2MoveID: pokemon2MoveID
        )
        
        let move = pokemon1.getMove(withID: attackID)!
        var message = "\(pokemon1.name) used \(move.name))"
        
        if move is PokemonAttack {
            message += " on \(pokemon2.name)!"
        }
        
        commentary = message
        
        let step1Result = battle.performRoundStep1()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if step1Result.didTrainer1PokemonFaint {
                self.commentary = "\(self.pokemon1.name) fainted!"
            }
            if step1Result.didTrainer2PokemonFaint {
                self.commentary = "\(self.pokemon2.name) fainted!"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.menuMode = .main
            }
        }
    }
}

// MARK: - Util
private extension Pokemon {
    var randomMove: PokemonMove {
        moves[Int.random(in: 0...(moves.count - 1))]
    }
}
