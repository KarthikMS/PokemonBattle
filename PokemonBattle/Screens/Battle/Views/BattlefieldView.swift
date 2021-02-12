//
//  BattlefieldView.swift
//  PokemonBattle
//
//  Created by Karthik on 02/11/20.
//

import SwiftUI

struct BattlefieldView: View {
    @ObservedObject var pokemon1: Pokemon
    @ObservedObject var pokemon2: Pokemon
    @ObservedObject var viewModel: BattleViewModel
    
    var body: some View {
        VStack {
            HStack {
                BattlePokemonDetailsView(
                    viewModel: BattlePokemonDetailsViewModel(
                        pokemon: pokemon2
                    )
                )
                PokemonView(pokemon: pokemon2)
                    .frame(width: 90, height: 90)
                    .opacity(viewModel.pokemon2FaintedAnimationEnabled ? 0 : 1)
                    .animation(viewModel.pokemon2FaintedAnimationEnabled ? .default : .none)
                    .modifier(PokemonAnimationViewModifier(pokemonAnimation: viewModel.pokemon2Animation))
            }
            HStack {
                PokemonView(pokemon: pokemon1)
                    .frame(width: 90, height: 90)
                    .opacity(viewModel.pokemon1FaintedAnimationEnabled ? 0 : 1)
                    .animation(viewModel.pokemon1FaintedAnimationEnabled ? .default : .none)
                    .modifier(PokemonAnimationViewModifier(pokemonAnimation: viewModel.pokemon1Animation))
                BattlePokemonDetailsView(
                    viewModel: BattlePokemonDetailsViewModel(
                        pokemon: pokemon1
                    )
                )
            }
        }
    }
}

struct BattlefieldView_Previews: PreviewProvider {
    static var previews: some View {
        BattlefieldView(
            pokemon1: StarterPokemon.charmander,
            pokemon2: StarterPokemon.mudkip,
            viewModel: BattleViewModel(
                trainer1: PreviewData.ash,
                trainer2: PreviewData.gary
            )
        )
    }
}
