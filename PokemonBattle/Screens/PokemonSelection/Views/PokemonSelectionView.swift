//
//  PokemonSelectionView.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

struct PokemonSelectionView: View {
    @ObservedObject var viewModel: PokemonSelectionViewModel
    @Dependency var pokeUtil: Pokeutil
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your pokemon")
                    .font(.headline)
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
                            }
                        )
                        .background(Color(pokeUtil.getThemeColor(for: pokemon.type)))
                    }
                }
            }
            .background(Color.yellow)
            .onAppear {
                viewModel.playBGMusic()
            }
            .onDisappear {
//                viewModel.stopBGMusic()
            }
        }
    }
}

struct PokemonSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectionView(viewModel: PokemonSelectionViewModel())
    }
}
