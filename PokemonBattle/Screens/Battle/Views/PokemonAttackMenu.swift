//
//  PokemonAttackMenu.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

struct PokemonAttackMenu: View {
    let pokemon: Pokemon
    @ObservedObject var viewModel: BattleViewModel
    
    private var moves: [(name: String, action: () -> Void)] {
        var moves = [(name: String, action: () -> Void)]()
        
        for move in pokemon.moves {
            moves.append((
                name: move.name,
                action: {
                    viewModel.performAttack(withID: move.id)
                }
            ))
        }
        
        while moves.count < 4 {
            moves.append((
                name: "-",
                action: { print("no move") }
            ))
        }
        
        return moves
    }
    
    var body: some View {
        BattleMenu(
            menu1Title: moves[0].name,
            menu1Action: moves[0].action,
            menu2Title: moves[1].name,
            menu2Action: moves[1].action,
            menu3Title: moves[2].name,
            menu3Action: moves[2].action,
            menu4Title: moves[3].name,
            menu4Action: moves[3].action
        )
    }
}

struct PokemonAttackMenu_Previews: PreviewProvider {
    static var previews: some View {
        return PokemonAttackMenu(
            pokemon: StarterPokemon.charmander,
            viewModel: BattleViewModel(
                trainer1: PreviewData.ash,
                trainer2: PreviewData.gary
            )
        )
    }
}
