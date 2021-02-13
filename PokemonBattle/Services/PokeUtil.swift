//
//  PokeUtil.swift
//  PokemonBattle
//
//  Created by Karthik on 12/02/21.
//

import UIKit

protocol Pokeutil {
    func getThemeColor(for pokemonType: ElementType) -> UIColor
}

final class PokeUtil: Pokeutil {
    func getThemeColor(for pokemonType: ElementType) -> UIColor {
        switch pokemonType {
        case .normal:
            return .gray
        case .fire:
            return .red
        case .water:
            return .blue
        case .grass:
            return .green
        @unknown default:
            return .gray
        }
    }
}
