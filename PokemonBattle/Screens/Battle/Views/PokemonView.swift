//
//  PokemonView.swift
//  PokemonBattle
//
//  Created by Karthik on 02/11/20.
//

import SwiftUI

struct PokemonView: View {
    var pokemon: Pokemon
    
    var body: some View {
        Image(pokemon.imageName)
            .resizable()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: StarterPokemon.charmander)
    }
}
