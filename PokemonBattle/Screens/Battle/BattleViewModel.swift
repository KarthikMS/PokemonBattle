//
//  BattleViewModel.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI
import Combine

// MARK: - Consants
let PokemonAttackSingleAnimationDuration: Double = 0.2
let PokemonAttackAnimationCount = 4
let PokemonAttackAnimationDuration: Double = Double(PokemonAttackAnimationCount) * PokemonAttackSingleAnimationDuration

final class BattleViewModel: ObservableObject {
    
    enum RoundStep {
        case awaitSummon
        case firstPokemonSummon
        case secondPokemonSummon
        case awaitInstructions
        case firstPokemonAttack
        case secondPokemonDamage
        case secondPokemonAttack
        case firstPokemonDamage
        case firstPokemonFaint
        case secondPokemonFaint
    }
    
    // MARK: - Properties
    private let trainer1: PokemonTrainer
    private let trainer2: PokemonTrainer
    private let isOpponentAI = true
    private var roundStep: RoundStep = .awaitInstructions//.awaitSummon
    
    // Commentary
    private var commentaryTimer: Timer?
    private var fullComment = ""
    private var commentaryCharIndex = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    // TODO: Check if changes need to be tracked.
    var pokemon1: Pokemon { battle.pokemon1 }
    var pokemon2: Pokemon { battle.pokemon2 }
    
    // MARK: - Published
    @Published var menuMode: BattleMainMenu.Mode = .mainMenu
    @Published var pokemon1FaintedAnimationEnabled = false
    @Published var pokemon2FaintedAnimationEnabled = false
    @Published var pokemon1Animation: PokemonAnimation = .idle
    @Published var pokemon2Animation: PokemonAnimation = .idle
    @Published var commentaryDisplayText = ""
    
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

// MARK: - Commentary
private extension BattleViewModel {
    func listenToCommentator() {
        commentator.commentStream
            .sink { comment in
                self.showAnimatedComment(comment)
            }
            .store(in: &cancellables)
    }
    
    func showAnimatedComment(_ comment: String) {
        self.fullComment = comment
        
        resetCommentary()
        
        commentaryTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            guard self.commentaryCharIndex < self.fullComment.count else {
                self.resetCommentary()
                return
            }
            let index = String.Index(utf16Offset: self.commentaryCharIndex, in: self.fullComment)
            DispatchQueue.main.async {
                self.commentaryDisplayText = String(self.fullComment[self.fullComment.startIndex...index])
            }
            self.commentaryCharIndex += 1
        }
        commentaryTimer?.fire()
    }
    
    func resetCommentary() {
        commentaryTimer?.invalidate()
        commentaryCharIndex = 0
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
        
        // 1. Which pokemon is going to do what?
        // 2. attacking pokemon animation
        // 3. defending pokemon damage
        // 4. Check faints
        // 5. small pause
        // 6. other pokemon attack animation
        // 7. defending pokemon damange
        // 8. Check faints
        
        // 1.
        let round1Details = battle.prepareForRound1()
        if round1Details.attackingPokemon == pokemon1 {
            pokemon1Animation = .attack
        } else {
            pokemon2Animation = .attack
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + PokemonAttackAnimationDuration) {
            if round1Details.attackingPokemon == self.pokemon1 {
                self.pokemon1Animation = .idle
            } else {
                self.pokemon2Animation = .idle
            }
        }
        
        // 2.
        let step1Result = battle.performRoundStep1()
        menuMode = .attackAnimation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + UserMessageReadTimeDuration) {
            if self.processRoundResult(stepResult: step1Result) {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.UserMessageReadTimeDuration) {
                let step2Result = self.battle.performRoundStep2()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.UserMessageReadTimeDuration) {
                    if self.processRoundResult(stepResult: step2Result) {
                        return
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
    private func processRoundResult(stepResult: RoundResult) -> Bool {
        var didPokemonFaint = false
        if stepResult.didTrainer1PokemonFaint {
            commentator.comment("\(pokemon1.name) fainted!")
            pokemon1FaintedAnimationEnabled = true
            didPokemonFaint = true
        }
        if stepResult.didTrainer2PokemonFaint {
            commentator.comment("\(pokemon2.name) fainted!")
            pokemon2FaintedAnimationEnabled = true
            didPokemonFaint = true
        }
        return didPokemonFaint
    }
}

// MARK: - Util
private extension Pokemon {
    var randomMove: PokemonMove {
        moves[Int.random(in: 0...(moves.count - 1))]
    }
}
