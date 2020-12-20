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
    
    var body: some View {
        VStack {
            HStack {
                BattlePokemonDetailsView(
                    viewModel: BattlePokemonDetailsViewModel(
                        pokemon: pokemon2
                    )
                )
                PokemonView(pokemon: pokemon2)
            }
            HStack {
                PokemonView(pokemon: pokemon1)
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
            pokemon1: PreviewData.charmander,
            pokemon2: PreviewData.mudkip
        )
    }
}