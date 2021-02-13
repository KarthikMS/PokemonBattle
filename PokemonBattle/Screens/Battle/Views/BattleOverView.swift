//
//  BattleOverView.swift
//  PokemonBattle
//
//  Created by Karthik on 13/02/21.
//

import SwiftUI

private struct BattleOverViewButton: View {
    let title: String
    let buttonAction: (() -> Void)
    
    var body: some View {
        Button(title, action: buttonAction)
        .font(.title2)
        .foregroundColor(.black)
        .multilineTextAlignment(.center)
        .frame(width: 200, height: 100, alignment: .center)
        .background(Color.yellow)
        .cornerRadius(12)
    }
}

struct BattleOverView: View {
    let text: String
    let button1Text: String
    let button2Text: String
    let button1Action: (() -> Void)
    let button2Action: (() -> Void)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.white
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.6)
                ZStack {
                    Color.orange
                        .frame(width: 300, height: 400, alignment: .center)
                        .cornerRadius(30)
                    VStack {
                        Spacer()
                        Text(text)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                        Spacer(minLength: 30)
                        BattleOverViewButton(title: button1Text, buttonAction: button1Action)
                        Spacer().frame(height: 20)
                        BattleOverViewButton(title: button2Text, buttonAction: button2Action)
                        Spacer()
                    }
                    .frame(width: 300, height: 400, alignment: .center)
                }
            }
        }
    }
}

struct BattleOverView_Previews: PreviewProvider {
    static var previews: some View {
        BattleOverView(
            text: "You won!",
            button1Text: "Play again",
            button2Text: "Choose different pokemon",
            button1Action: {
                print("Button 1")
            },
            button2Action: {
                print("Button 2")
            }
        )
    }
}
