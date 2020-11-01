//
//  BattleMainMenu.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

struct BattleMainMenu: View {
    enum Mode {
        case main
        case attack
        case attackAnimation
    }
    
    @ObservedObject var viewModel: BattleViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // TODO: Replace this with BattleView
                Text("Battle area")
                    .frame(
                        width: geometry.size.width,
                        height: 0.8 * geometry.size.height
                    )
                    .background(Color.red)
                
                ZStack {
                    Color.green
                    
                    if viewModel.menuMode == .main {
                        BattleMenu(
                            menu1Title: "Attack",
                            menu1Action: { self.viewModel.menuMode = .attack },
                            menu2Title: "Bag",
                            menu2Action: { print("Bag") },
                            menu3Title: "Pokemon",
                            menu3Action: { print("Pokemon") },
                            menu4Title: "Run",
                            menu4Action: { print("Run") }
                        )
                    }
                    
                    if viewModel.menuMode == .attack {
                        VStack {
                            PokemonAttackMenu(
                                pokemon: viewModel.pokemon1,
                                viewModel: viewModel
                            )
                            Button("Back") {
                                self.viewModel.menuMode = .main
                            }
                            .foregroundColor(.red)
                        }
                    }
                    
                    if viewModel.menuMode == .attackAnimation {
                        Text(viewModel.commentary)
                    }
                }
            }
        }
    }
}

struct BattleMainMenu_Previews: PreviewProvider {
    static var previews: some View {
        BattleMainMenu(
            viewModel: BattleViewModel(
                trainer1: PreviewData.ash,
                trainer2: PreviewData.gary
            )
        )
    }
}
