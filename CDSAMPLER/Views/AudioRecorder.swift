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
    
    ///TODO: IMPLEMENT
    // Find iOS device built in mic input by querying the available inputs for the one where the port type equals the built in mic, and sets as preferred input
    private func enableBuiltInMic() {
        // Get the shared audio session
        let session = AVAudioSession.sharedInstance()
        
        // Find built in mic input, if we can't we return
        guard let availableInputs = session.availableInputs,
              let builtInMicInput = availableInputs.first(where: { $0.portType == .builtInMic }) else {
            print("The device must have a built in microphone")
            return
        }
        
        // Set the built in microphone input as the preferred input
        do {
            
            try session.setPreferredInput(builtInMicInput)
            
        } catch {
            print("uh oh, unable to set the built in mic as the preferred input")
        }
        
    }
    
    ///TODO: IMPLEMENT
    
//    func selectRecordingOption(_ option: RecordingOption, orientation: Orientation, completion: (StereoLayout) -> Void) {
//
//        // Get shared audio Session
//        let session = AVAudioSession.sharedInstance()
//
//        // Find built in mic input data sources and select the one that matches the specified name
//        guard let preferredInput = session.preferredInput,
//              let dataSources = preferredInput.dataSources,
//              let newDataSource = dataSources.first(where: { $0.dataSourceName == option.dataSourceName}),
//              let supportedPolarPatterns = newDataSource.supportedPolarPatterns else {
//            completion(.none)
//            return
//        }
//
//        do {
//            isStereoSupported = supportedPolarPatterns.contains(.stereo)
//        }
//
//    }
//
    
    func startRecording() {
        
        // Create recording session with AVAudioSession
        let recordingSession = AVAudioSession.sharedInstance()
        
        
        // Define type for recording session and activate
        do {
            // options routes audio to speakers (not receiver) and bluetooth headphones
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try recordingSession.setActive(true)
            
        } catch {
            print("Failed to start audio recording session")
        }
        
        
        // Specify location of (saved) Audio recording
        let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let audioFilename = savePath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY'at'_HH:mm:ss")).wav")
        
        // Define settings for recording params (Should be modifiable by user in a settings view)
        
        //TODO: implement check for AVNumberOfChannelsKey to record stereo if available.
        // Setup for .wav linear pcm at 44khz 16bit
        ///TODO: implement settings for AVFormatIDKey
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVLinearPCMIsNonInterleaved: false,
            AVSampleRateKey: 44_100.0,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16
        ]
        
        
        
        
        // Start recording here
        do {
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            // update our observer
            recording = true
            
        } catch {
            print("ERROR, COULD NOT BEGIN RECORDING AT: \(error.localizedDescription)")
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
    
    
    // accepts array of URLS and deltes corresponding files from the directory
    // on completion we update our recordings array using getRecording()
    func deleteRecording(urlsToDelete: [URL]) {
        
        for url in urlsToDelete {
            
            print(url)
            
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("ERROR, FILE COULD NOT BE DELETED")
            }
        }
        
        getRecordings()
    }
}



