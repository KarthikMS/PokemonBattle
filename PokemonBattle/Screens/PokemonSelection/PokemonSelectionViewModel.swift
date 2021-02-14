//
//  PokemonSelectionViewModel.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

final class PokemonSelectionViewModel: ObservableObject {
    // MARK: - Dependencies
    @Dependency(name: "bgAudioPlayer") private var bgAudioPlayer: PBAudioPlayer
    
    // MARK: - Properties
    var pokemons = [
        StarterPokemon.charmander,
        StarterPokemon.mudkip,
        StarterPokemon.bulbasaur
    ]
}

// MARK: - View Intents
extension PokemonSelectionViewModel {
    func playBGMusic() {
        DispatchQueue.global(qos: .background).async {
            self.bgAudioPlayer.loadAudio(named: "Pokemon_Selection_Theme", andPlay: true, shouldRepeat: true)
        }
    }
    
    func stopBGMusic() {
        DispatchQueue.global(qos: .background).async {
            self.bgAudioPlayer.stopAudio()
        }
    }
}

// MARK: - View Inputs
extension PokemonSelectionViewModel {
    func getPokemonTrainerWithPokemon(_ pokemon: Pokemon) -> PokemonTrainer {
        PokemonTrainer(name: "Ash", pokemons: [pokemon])
    }
    
    func getPokemonTrainerWithPokemonOtherThan(_ pokemon: Pokemon) -> PokemonTrainer {
        let trainerPokemon = pokemons
            .filter { $0 != pokemon }
            .randomElement()!
        return PokemonTrainer(name: "Gary", pokemons: [trainerPokemon])
    }
}
