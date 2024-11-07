//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/7/24.
//

import AVFoundation
import Foundation
import Observation

@Observable
class SoundPlayer {
    var audioPlayer: AVAudioPlayer!
    var isPlaying = false
    
    func getSound(name: String) {
        print("\(name)")
        if let sound = Bundle.module.url(forResource: name, withExtension: "mp3"){
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: sound)
            } catch {
                print("AVAudioPlayer error: \(error.localizedDescription)")
            }
        } else {
            print("Couldn't find sound.")
        }
    }
    
    func playerHandler() {
        guard let audioPlayer else { return }
        
        if isPlaying {
            // To Pause
            audioPlayer.pause()
            isPlaying = false
        } else {
            // To Play
            audioPlayer.play()
            isPlaying = true
        }
        
    }
}
