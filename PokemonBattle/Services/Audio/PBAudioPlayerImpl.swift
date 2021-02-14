//
//  PBAudioPlayerImpl.swift
//  PokemonBattle
//
//  Created by Karthik on 14/02/21.
//

import AVFoundation

final class PBAudioPlayerImpl: PBAudioPlayer {
    // MARK: - Properties
    private let killGuardTime: Double
    private var audioPlayer: AVAudioPlayer?
    private var canKill = true
    
    // MARK: - Init
    init(killGuardTime: Double = 2) {
        self.killGuardTime = killGuardTime
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}

// MARK: - PBAudioPlayer
extension PBAudioPlayerImpl {
    func loadAudio(named fileName: String, andPlay shouldPlay: Bool = false, shouldRepeat: Bool = false, withKillGuard: Bool) {
        do {
            let path: String
            
            if let mp3Path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
                path = mp3Path
            } else if let wavPath = Bundle.main.path(forResource: fileName, ofType: "wav") {
                path = wavPath
            } else {
                return
            }            
            
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            if shouldPlay {
                if withKillGuard {
                    canKill = false
                    enableKillGuard()
                }
                audioPlayer?.play()
                audioPlayer?.numberOfLoops = shouldRepeat ? -1 : 0
            }
        } catch {
            assertionFailure(error.localizedDescription)
            audioPlayer = AVAudioPlayer()
        }
    }
    
    func playLoadedAudio() {
        audioPlayer?.play()
    }
    
    func stopAudio() {
        guard canKill else { return }
        
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        audioPlayer = nil
    }
}

// MARK: - Kill Guard
private extension PBAudioPlayerImpl {
    func enableKillGuard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + killGuardTime) {
            self.canKill = true
        }
    }
}
