//
//  AudioPlayer.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/16/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation


// AVAudioPlayerDelegate allows for notification of end of playback. protocol requires adaption of the NSObject protocol
class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    // PassthroughObject to notify our observing views about changes (i.e if audio is being played or not)
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    // Boolean value that tells us if the player is playing, we inform the observing views/state on changes
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    
    
    /// starts playback of input file
    /// - Parameter audio: URL,  file path for the audio to be played
    /// - NOTE: will need to be adjusted for streaming
    func startPlayback (audio: URL) {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        // Audio is played through earpiece by default, set to speaker
        // NOTE: probably dont need anymore?
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Failed to play audio via device speakers")
        }
        
        // Start playing audio and inform observing views
        // When audio is played, set audioplayer to be AVAudioPlayer delegate
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("PLAYBACK FAILED")
        }
        
    }
    
    
    // Stops playback, updates observer
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    
    // If audio was successfully played, set the playback properties back to false
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if flag {
            isPlaying = false
        }
    }
    
    
}
