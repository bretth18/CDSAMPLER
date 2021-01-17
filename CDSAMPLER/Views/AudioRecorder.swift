//
//  AudioRecorder.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/16/21.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation


class AudioRecorder: NSObject, ObservableObject {
    
    // Intializer updates recordings array when launched/first time. Conforms to NSObject Protocol
    override init() {
        super.init()
        getRecordings()
    }
    
    // Passthrough object to notify observing views about changes (e.g recording started)
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    // Initializer for an AVAudioRecorder instance
    var audioRecorder: AVAudioRecorder!
    
    // Initialize Array to hold local recordings
    var recordings = [Recording]()
    
    
    // if recording changes (e.g finished), we will update subscribing views using the objectWillChange property
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    
    
    func startRecording() {
        
        // Create recording session with AVAudioSession
        let recordingSession = AVAudioSession.sharedInstance()
        
        
        // Define type for recording session and activate
        do {
            
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
        } catch {
            print("Failed to start audio recording session")
        }
        
        
        // Specify location of (saved) Audio recording
        let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let audioFilename = savePath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY'at'_HH:mm:ss")).m4a")
        
        // Define settings for recording params (Should be modifiable by user in a settings view)
        
        //TODO: setup stereo audio recording in hq audio
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        
        
        
        // Start recording here
        do {
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            // update our observer
            recording = true
            
        } catch {
            print("ERROR, COULD NOT BEGIN RECORDING")
        }
    }
    
    
    func stopRecording() {
        
        // Stop audio recording, update state
        audioRecorder.stop()
        recording = false
        
        // Call getRecordings to update the displayed recordings
        getRecordings()
    }
    
    
    // Getter function to access locally stored recordings
    func getRecordings() {
        
        // Each time we get the recordings we need to empty our "recordings" array to avoid displaying the same recording multiple times
        
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        
        // Cycle through path
        for audio in directoryContents {
            
            // Creating one Recording instance per aduio file and adding it to our Recordings array
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        // Sort the recordings array by creation date and update observing views/state
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        objectWillChange.send(self)
    }
}



