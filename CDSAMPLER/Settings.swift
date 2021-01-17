//
//  Settings.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/17/21.
//

import Foundation
import Combine

// View model for user settings

class Settings: ObservableObject {
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var isPrivate: Bool {
        didSet {
            UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate")
        }
    }
    
    // Conforms to AVFormatIDKey in AudioRecorder, needs to be implemented as an observed setting
    @Published var recordingCodec: String {
        didSet {
            UserDefaults.standard.set(recordingCodec, forKey: "recordingCodec")
        }
    }
    
    
    // Codec set
    public var recordingCodecs = ["AppleLossless","MPEG4AAC", "LinearPCM", "FLAC"]
    
    
    // Initialize default user setttings, here we're setting the default codec to LinearPCM (needs to be implemented in recorder!)
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
        self.recordingCodec = UserDefaults.standard.object(forKey: "recordingCodec") as? String ?? "LinearPCM"
    }
}
