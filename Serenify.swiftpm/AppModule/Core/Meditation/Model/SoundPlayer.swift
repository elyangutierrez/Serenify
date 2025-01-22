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
    
    // Attributes
    var audioPlayer: AVAudioPlayer!
    var isPlaying = false
    var changeImage = false
    var duration: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var soundReady = false
    var isLooping = false
    var isMuted = false
    var currentVolume = Float(0)
    
    var formattedCurrentTime: String {
        
        // Formats current time
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        // Format the time
        let formattedTime = formatter.string(from: currentTime) ?? "0:00"
        
        // Remove the leading zero if present
        if formattedTime.hasPrefix("0") && formattedTime.count > 4 {
            return String(formattedTime.dropFirst())
        }
        
        return formattedTime
    }
    
    var formattedTimeLeft: String {
        
        let remainingTime = duration - currentTime
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        let formattedTime = formatter.string(from: remainingTime)!
        
        if formattedTime.hasPrefix("0") && formattedTime.count > 4 {
            return String(formattedTime.dropFirst())
        }
        
        return formattedTime
    }
    
    func getSound(name: String) {
        
        /* Gets the sound by finding the file in the bundle and stores a
           AVAudioPlayer inside the audioPlayer with the given sound.
           The duration and currentTime attributes are also set. */
        
        print("\(name)")
        if let sound = Bundle.module.url(forResource: name, withExtension: "mp3"){
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: sound)
                self.soundReady = self.audioPlayer.prepareToPlay()
                duration = audioPlayer.duration
                currentTime = audioPlayer.currentTime
            } catch {
                print("AVAudioPlayer error: \(error.localizedDescription)")
            }
        } else {
            print("Couldn't find sound.")
        }
    }
    
    @MainActor func playerHandler() {
        
        // Handles the play state
        
        guard let audioPlayer else { return }
        
        DispatchQueue.main.async { [self] in
            if isPlaying && soundReady {
                // To Pause
                audioPlayer.pause()
                isPlaying = false
            } else if !isPlaying && soundReady {
                // To Play
                audioPlayer.play()
                isPlaying = true
            }
        }
    }
    
    func goForwardTenSeconds() {
        
        // Goes forward 10 seconds
        
        guard let audioPlayer else { return }
        
        let currentLength = duration - currentTime
        
        if currentLength < 10 && !isLooping {
            // Prevents users from overskipping and instantly restarting the track
            audioPlayer.currentTime += currentLength
            currentTime = audioPlayer.currentTime
            audioPlayer.stop()
            self.isPlaying = false
            self.changeImage = false
        } else if currentTime < duration {
            audioPlayer.currentTime += 10
            currentTime = audioPlayer.currentTime
        }
    }
    
    func goBackwardTenSeconds() {
        
        // Goes backward 10 seconds
        
        guard let audioPlayer else { return }
        
        if currentTime <= duration {
            audioPlayer.currentTime -= 10
            currentTime = audioPlayer.currentTime
        } else {
            audioPlayer.stop()
            currentTime = 0
        }
    }
    
    @MainActor func loopAudio() {
        
        // Loops the current sound that is playing
        
        guard let audioPlayer else { return }
        
        if isLooping {
            audioPlayer.numberOfLoops = -1
        } else {
            audioPlayer.numberOfLoops = 0
            
            // If the user stops the loop, pause the audio
            if self.changeImage || self.isPlaying {
                self.changeImage = false
                self.isPlaying = false
                audioPlayer.pause()
            }
        }
    }
    
    func muteAudio() {
        
        // Mutes the current sound that is playing
        
        guard let audioPlayer else { return }
        
        if isMuted {
            currentVolume = audioPlayer.volume
            audioPlayer.volume = 0
        } else {
            audioPlayer.volume = currentVolume
        }
    }
    
    func updateVariables() {
        
        // With the use of a timer, update the variables each second
        
        currentTime = audioPlayer.currentTime
        duration = audioPlayer.duration
    }
    
    func terminatePlayer() {
        
        // Kills the audioPlayer and restores back to original state
        
        audioPlayer = nil
        isPlaying = false
        changeImage = false
        isLooping = false
        isMuted = false
    }
}
