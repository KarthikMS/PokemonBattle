//
//  BattlePokemonDetailsView.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI
import Combine

final class BattlePokemonDetailsViewModel: ObservableObject {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published
    let name: String
    let maxHP: Float
    @Published var currentHP: Float = 1
    @Published var healthText = ""
    
    // MARK: - Init
    init(pokemon: Pokemon) {
        name = pokemon.name
        currentHP = Float(pokemon.currentHP)
        maxHP = Float(pokemon.maxHP)
        healthText = "\(pokemon.currentHP) / \(pokemon.maxHP)"
        
        observeHealth(of: pokemon)
    }
    
    // MARK: - Setup
    private func observeHealth(of pokemon: Pokemon) {
        pokemon.$currentHP
            .receive(on: DispatchQueue.main)
            .sink { currentHealth in
                self.healthText = "\(currentHealth) / \(pokemon.maxHP)"
                self.currentHP = Float(currentHealth)
            }
            .store(in: &cancellables)
    }
}

struct BattlePokemonDetailsView: View {
    @ObservedObject var viewModel: BattlePokemonDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.name)
            
            HStack {
                Text("HP")
                ProgressView(value: viewModel.currentHP, total: viewModel.maxHP)
            }
            .padding(.trailing, 10)
            
            Text(viewModel.healthText)
        }
    }
}

struct BattlePokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BattlePokemonDetailsView(
            viewModel: BattlePokemonDetailsViewModel(
                pokemon: PreviewData.charmander
            )
        )
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}
