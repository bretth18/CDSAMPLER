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
            // Apply delete functionality to every row
            .onDelete(perform: delete)
        }
    }
    
    // Allows for deletion after pressing edit in parent view
    // Offsets represents a set of indexes of recording rows that the user has chosen to delete
    // with this array we create an array of the file paths of the recordings to be deleted
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        // Call to delete from file directory
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    // Each recording row is given an AudioPlayer for the respective audio recording.
    // NOTE: may not be the best way
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        
        // Assign each row to the path of the audio file
        HStack {
            
            
            Text("\(audioURL.lastPathComponent)").foregroundColor(.white)
            Spacer()
            
            // Show buttons for playback
            if audioPlayer.isPlaying == false {
                
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
                
            } else {
                
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
                
            }
        }
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(audioRecorder: AudioRecorder())
    }
}
