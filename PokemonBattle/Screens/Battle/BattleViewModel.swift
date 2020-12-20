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
    @Published var menuMode: BattleMainMenu.Mode = .mainMenu
    @Published var commentary = ""
    @Published var pokemon1FaintedAnimationEnabled = false
    @Published var pokemon2FaintedAnimationEnabled = false
    
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
    
    // MARK: - Temp
    private let UserMessageReadTimeDuration = 1.5
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
        let pokemon2Move = battle.pokemon2.randomMove
        
        battle.setRoundParams(
            pokemon1MoveID: attackID,
            pokemon2MoveID: pokemon2Move.id
        )
        
        let step1Result = battle.performRoundStep1()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + UserMessageReadTimeDuration) {
            if self.didPokemonFaint(stepResult: step1Result) {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.UserMessageReadTimeDuration) {
                let step2Result = self.battle.performRoundStep2()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.UserMessageReadTimeDuration) {
                    if step2Result.didTrainer1PokemonFaint {
                        self.commentary = "\(self.pokemon1.name) fainted!"
                    }
                    if step2Result.didTrainer2PokemonFaint {
                        self.commentary = "\(self.pokemon2.name) fainted!"
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.menuMode = .mainMenu
                    }
                }
            }
        }
    }
    
    // TODO: Remove side-effects from this function.
    /// Returns shouldContinue
    private func didPokemonFaint(stepResult: RoundResult) -> Bool {
        if stepResult.didTrainer1PokemonFaint {
            commentary = "\(pokemon1.name) fainted!"
            pokemon1FaintedAnimationEnabled = true
            return true
        }
        if stepResult.didTrainer2PokemonFaint {
            commentary = "\(pokemon2.name) fainted!"
            pokemon2FaintedAnimationEnabled = true
            return true
        }
        return false
    }
}

// MARK: - Util
private extension Pokemon {
    var randomMove: PokemonMove {
        moves[Int.random(in: 0...(moves.count - 1))]
    }
}
