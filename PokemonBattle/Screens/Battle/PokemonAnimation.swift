//
//  PokemonAnimation.swift
//  PokemonBattle
//
//  Created by Karthik on 25/12/20.
//

import SwiftUI

enum PokemonAnimation {
    case summon
    case idle
    case attack
    case damage
    case faint
}

struct PokemonAnimationViewModifier: ViewModifier {
    let pokemonAnimation: PokemonAnimation
    
    func body(content: Content) -> some View {
        switch pokemonAnimation {
        case .attack:
            return content
                .rotationEffect(.degrees(30))
                .animation(
                    Animation.easeIn(duration: PokemonAttackSingleAnimationDuration)
                        .repeatCount(PokemonAttackAnimationCount, autoreverses: true)
                )
        default:
            return content
                .rotationEffect(.zero)
                .animation(.easeIn)
        }
    }
}
