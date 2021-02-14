//
//  PBAudioPlayer.swift
//  PokemonBattle
//
//  Created by Karthik on 14/02/21.
//

protocol PBAudioPlayer {
    func loadAudio(named fileName: String, andPlay shouldPlay: Bool, shouldRepeat: Bool, withKillGuard: Bool)
    func playLoadedAudio()
    func stopAudio()
}

extension PBAudioPlayer {
    func loadAudio(named fileName: String) {
        loadAudio(named: fileName, andPlay: false)
    }
    
    func loadAudio(named fileName: String, andPlay shouldPlay: Bool) {
        loadAudio(named: fileName, andPlay: shouldPlay, shouldRepeat: false)
    }
    
    func loadAudio(named fileName: String, andPlay shouldPlay: Bool, shouldRepeat: Bool) {
        loadAudio(named: fileName, andPlay: shouldPlay, shouldRepeat: shouldRepeat, withKillGuard: true)
    }
}
