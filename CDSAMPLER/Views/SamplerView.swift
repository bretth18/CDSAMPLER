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
    
    // Need to acess SessionStore so we can conditionally render the auth screen if the user isnt logged in (needs to be implmeneted more top level, will setup nav in future
    
    @EnvironmentObject var authState: AuthenticationState
    
    // Initializer to setup Navbar Styling
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Initialize the AudioRecorder
        audioRecorder = AudioRecorder()
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                Color.black.ignoresSafeArea()
                
        
                
                // Vstack for recording button
                VStack {
                    
                    // RecordingListView component
                    RecordingListView(audioRecorder: AudioRecorder())
                
                    
                    
                    if audioRecorder.recording == false {
                        Button(action: {self.audioRecorder.startRecording()}) {
                            Image(systemName: "record.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .foregroundColor(.red)
                                .padding(.bottom, 40)
                        }
                        
                    } else {
                        
                        Button(action: {self.audioRecorder.stopRecording()}) {
                            Image(systemName: "stop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .foregroundColor(.red)
                                .padding(.bottom, 40)
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("CD_SAMPLER").foregroundColor(.white)
            .navigationBarItems(trailing:
                                    // Navbar buttons
                                    HStack {
                                        EditButton()
                                        Button(action: {}, label: {NavigationLink(destination: SettingsView()) {
                                            Image(systemName: "gearshape")
                                        }})
                                    }
                                
                )
        }
        
    }
}

struct SamplerView_Previews: PreviewProvider {
    static var previews: some View {
        // Init audioRecorder instance
        SamplerView()
    }
}
