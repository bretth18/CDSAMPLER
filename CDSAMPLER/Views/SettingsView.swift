//
//  SettingsView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/17/21.
//

import SwiftUI

struct SettingsView: View {
    
    // Observed object
    @ObservedObject var userSettings = Settings()
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("PROFILE")) {
                    TextField("USERNAME", text: $userSettings.username)
                    Toggle(isOn: $userSettings.isPrivate) {
                        Text("PRIVATE ACCOUNT")
                    }
                    
                    Picker(selection: $userSettings.recordingCodec, label: Text("RECORDING CODEC")) {
                        ForEach(userSettings.recordingCodecs, id: \.self) { recordingCodec in
                            Text(recordingCodec)
                        }
                    }
                }
            }
            
            .navigationBarTitle("SETTINGS")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
