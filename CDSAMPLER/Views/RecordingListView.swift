//
//  RecordingListView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/16/21.
//

import SwiftUI

struct RecordingListView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in RecordingRow(audioURL: recording.fileURL)
            }
        }
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    var body: some View {
        
        // Assign each row to the path of the audio file
        HStack {
            
//            Color.black.ignoresSafeArea()
            
            Text("\(audioURL.lastPathComponent)").foregroundColor(.white)
            Spacer()
        }
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(audioRecorder: AudioRecorder())
    }
}
