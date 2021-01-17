//
//  SamplerView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/16/21.
//

import SwiftUI

struct SamplerView: View {
    
    // View needs to access the AudioRecorder instance
    @ObservedObject var audioRecorder: AudioRecorder
    
    // Initializer to setup Navbar Styling
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        audioRecorder = AudioRecorder()
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                Color.black.ignoresSafeArea()
                
                Text("sampler")
                
                
                
                
                // Vstack for recording button
                VStack {
                    
                    // RecordingListView component
                    RecordingListView(audioRecorder: AudioRecorder())
                    
                    
                    if audioRecorder.recording == false {
                        Button(action: {self.audioRecorder.startRecording()}) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .foregroundColor(.red)
                                .padding(.bottom, 40)
                        }
                    } else {
                        
                        Button(action: {self.audioRecorder.stopRecording()}) {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .foregroundColor(.red)
                                .padding(.bottom, 40)
                        }
                    }
                }
            }
            .navigationTitle("CD_SAMPLER").foregroundColor(.white)
        }
    }
}

struct SamplerView_Previews: PreviewProvider {
    static var previews: some View {
        // Init audioRecorder instance
        SamplerView()
    }
}
