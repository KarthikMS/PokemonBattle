//
//  PokemonSelectionCard.swift
//  PokemonBattle
//
//  Created by Karthik on 11/02/21.
//

import SwiftUI

struct PokemonSelectionCard: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            Image(pokemon.imageName)
                .resizable()
                .frame(width: 50, height: 50)
            Text(pokemon.name)
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

struct PokemonSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectionCard(pokemon: StarterPokemon.charmander)
    }
}
