//
//  BattleMenu.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import SwiftUI

struct BattleMenu: View {
    let menu1Title: String
    let menu1Action: () -> Void
    
    let menu2Title: String
    let menu2Action: () -> Void
    
    let menu3Title: String
    let menu3Action: () -> Void
    
    let menu4Title: String
    let menu4Action: () -> Void
    
    let buttonCenterColor = Color(UIColor.darkGray)
    let buttonBorderColor = Color(UIColor.lightGray)
    let buttonBorderWidth: CGFloat = 15
    
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack {
                    Button(menu1Title, action: menu1Action)
                        .frame(width: 0.5 * g.size.width,
                               height: 0.5 * g.size.height)
                        .border(buttonBorderColor, width: buttonBorderWidth)
                    Button(menu2Title, action: menu2Action)
                        .frame(width: 0.5 * g.size.width,
                               height: 0.5 * g.size.height)
                        .border(buttonBorderColor, width: buttonBorderWidth)
                }
                HStack {
                    Button(menu3Title, action: menu3Action)
                        .frame(width: 0.5 * g.size.width,
                               height: 0.5 * g.size.height)
                        .border(buttonBorderColor, width: buttonBorderWidth)
                    Button(menu4Title, action: menu4Action)
                        .frame(width: 0.5 * g.size.width,
                               height: 0.5 * g.size.height)
                        .border(buttonBorderColor, width: buttonBorderWidth)
                }
            }
            .font(.title2)
            .foregroundColor(Color.white)
            .background(buttonCenterColor)
        }
    }
}

struct BattleMenu_Previews: PreviewProvider {
    static var previews: some View {
        BattleMenu(
            menu1Title: "Explosion", menu1Action: { print("Explosion") },
            menu2Title: "Thunderbolt", menu2Action: { print("Thunderbolt") },
            menu3Title: "Thunder Wave", menu3Action: { print("Thunder Wave") },
            menu4Title: "Thunder", menu4Action: { print("Thunder") })
    }
}
