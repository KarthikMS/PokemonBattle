//
//  CommentaryView.swift
//  PokemonBattle
//
//  Created by Karthik on 25/12/20.
//

import SwiftUI

struct CommentaryView: View {
    @Binding var comment: String
    
    var body: some View {
        Text(comment)
            .multilineTextAlignment(.leading)
    }
}

struct CommentaryView_Previews: PreviewProvider {
    static var previews: some View {
        CommentaryView(comment: .constant("hey"))
    }
}
