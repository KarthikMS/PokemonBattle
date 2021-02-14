//
//  BattleMainMenu.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

struct BattleMainMenu: View {
    enum Mode {
        case mainMenu
        case attackMenu
        case attackAnimation
        case battleOver
    }
    
    @ObservedObject var viewModel: BattleViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack {
                    // TODO: Replace this with BattleView
                    BattlefieldView(
                        pokemon1: viewModel.pokemon1,
                        pokemon2: viewModel.pokemon2,
                        viewModel: viewModel
                    )
                    .frame(
                        width: geometry.size.width,
                        height: 0.8 * geometry.size.height
                    )
                    .background(Color.red)
                    
                    ZStack {
                        Color.green
                        
                        if viewModel.menuMode == .mainMenu {
                            BattleMenu(
                                menu1Title: "Attack",
                                menu1Action: { self.viewModel.menuMode = .attackMenu },
                                menu2Title: "Bag",
                                menu2Action: { print("Bag") },
                                menu3Title: "Pokemon",
                                menu3Action: { print("Pokemon") },
                                menu4Title: "Run",
                                menu4Action: {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            )
                        }
                        
                        if viewModel.menuMode == .attackMenu {
                            VStack {
                                PokemonAttackMenu(
                                    pokemon: viewModel.pokemon1,
                                    viewModel: viewModel
                                )
                                Button("Back") {
                                    self.viewModel.menuMode = .mainMenu
                                }
                                .foregroundColor(.red)
                            }
                        }
                        
                        if viewModel.menuMode == .attackAnimation {
                            CommentaryView(comment: $viewModel.commentaryDisplayText)
                        }
                    }
                }
                BattleOverView(
                    text: viewModel.battleOverViewTitle,
                    button1Text: viewModel.battleOverViewButton1Text,
                    button2Text: "Choose different pokemon",
                    button1Action: {
                        viewModel.replayButtonPressed()
                    },
                    button2Action: {
                        viewModel.chooseNewPokemonButtonPressed()
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .offset(x: 0, y: viewModel.menuMode == .battleOver ? 0 : geometry.size.height)
            }
        }
        .onAppear {
            viewModel.playBGMusic()
            viewModel.playPokeBallOpenSound()
        }
        .onDisappear {
            viewModel.stopBGMusic()
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
