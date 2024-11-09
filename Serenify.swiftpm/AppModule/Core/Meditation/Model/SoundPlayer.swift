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
    
    // Formats current time
    var formattedCurrentTime: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: currentTime)!
    }
    
    // Formats the time remaining
    var formattedTimeLeft: String {
        
        let remainingTime = duration - currentTime
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: remainingTime)!
    }
    
    /* Gets the sound by finding the file in the bundle and stores a
       AVAudioPlayer inside the audioPlayer with the given sound.
       The duration and currentTime attributes are also set. */
    func getSound(name: String) {
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
        
        // TODO: Figure out a way to prevent going over and restarting.
        
        if currentTime < duration {
            audioPlayer.currentTime += 10
            currentTime = audioPlayer.currentTime
        } else {
            print("Can't go over duration.")
        }
    }
    
    func goBackwardTenSeconds() {
        // Goes backward 10 seconds
        
        guard let audioPlayer else { return }
        
        if currentTime <= duration {
            audioPlayer.currentTime -= 10
            currentTime = audioPlayer.currentTime
        } else {
            currentTime = 0
        }
    }
    
    func updateVariables() {
        // With the use of a timer, update the variables each second
        currentTime = audioPlayer.currentTime
        duration = audioPlayer.duration
    }
    
    func terminateProcesses() {
        // Kills the audioPlayer and restores back to original state
        audioPlayer = nil
        isPlaying = false
        changeImage = false
    }
}
