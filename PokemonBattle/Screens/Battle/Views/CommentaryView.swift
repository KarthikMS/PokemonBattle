//
//  CommentaryView.swift
//  PokemonBattle
//
//  Created by Karthik on 25/12/20.
//

import SwiftUI

struct CommentaryView: View {
    @StateObject private var viewModel = CommentaryViewModel()
    
    var message: String {
        didSet {
            viewModel.didSetMessage(message)
        }
    }
    
    
    var body: some View {
        Text(viewModel.text)
            .multilineTextAlignment(.leading)
            .onAppear() { onAppear() }
    }
    
    private func onAppear() {
        viewModel.didSetMessage(message)
    }
}

private class CommentaryViewModel: ObservableObject {
    @Published var text = ""
    
    private var message = ""
    private var charIndex = 0
    
    private var timer: Timer?
    
    func didSetMessage(_ message: String) {
        self.message = message
        
        reset()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            guard self.charIndex < self.message.count else { return }
            let index = String.Index(utf16Offset: self.charIndex, in: self.message)
            self.text = String(self.message[self.message.startIndex...index])
            self.charIndex += 1
        }
        timer?.fire()
    }
    
    private func reset() {
        timer?.invalidate()
        charIndex = 0
    }
}

struct CommentaryView_Previews: PreviewProvider {
    static var previews: some View {
        CommentaryView(message: "g")
    }
}
