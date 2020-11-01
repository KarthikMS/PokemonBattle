//
//  Pokemon+Battle.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

extension Pokemon {
    func battleSpeed(afterApplying effects: [BattleEffect]) -> Int {
        for effect in effects {
            switch effect {
            case let .speedMutation(diff):
                return speed + diff
            }
        }
        return speed
    }
    
    func performMove(_ move: PokemonMove, opponent: Pokemon) {
        if let attack = move as? PokemonAttack {
            self.attack(opponent, using: attack)
        }
    }
    
    func attack(_ opponent: Pokemon, using attack: PokemonAttack) {
        let damage: Int
        
        switch attack.effectOn(pokemonOfType: opponent.type) {
        case .normal:
            damage = attack.damage
        case .superEffective:
            damage = attack.damage * 2
        case .notVeryEffective:
            damage = attack.damage / 2
        case .doesNotAffect:
            damage = 0
        }
        
        opponent.currentHP -= damage
    }
}

extension PokemonAttack {
    func effectOn(pokemonOfType pokemonType: ElementType) -> PokemonAttackEffect {
        switch elementType {
        case .normal:
            return .normal
            
        case .fire:
            switch pokemonType {
            case .fire, .water:
                return .notVeryEffective
            case .grass:
                return.superEffective
            default:
                return .normal
            }
            
        case .water:
            switch pokemonType {
            case .water, .grass:
                return .notVeryEffective
            case .fire:
                return .superEffective
            default:
                return .normal
            }
            
        case .grass:
            switch pokemonType {
            case .grass, .fire:
                return .notVeryEffective
            case .water:
                return .superEffective
            default:
                return .normal
            }
        }
    }
}

