//
//  PokemonSelectionView.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

struct PokemonSelectionView: View {
    @ObservedObject var viewModel: PokemonSelectionViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemons) { pokemon in
                    NavigationLink(
                        destination: BattleMainMenu(
                            viewModel: BattleViewModel(
                                trainer1: viewModel.getPokemonTrainerWithPokemon(pokemon),
                                trainer2: viewModel.getPokemonTrainerWithPokemonOtherThan(pokemon)
                            )),
                        label: {
                            PokemonSelectionCard(pokemon: pokemon)
                        })
                }
            }
        }
    }
}

struct PokemonSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectionView(viewModel: PokemonSelectionViewModel())
    }
}
