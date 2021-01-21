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
    
    // Environment object for authentication
    @EnvironmentObject var authState: AuthenticationState
    
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
                
                // About section
                Section(header: Text("ABOUT")) {
                    Text("BUILD NUMBER: 0.0.0")
                }
                
                
                Section(header: Text("ACCOUNT")) {
                    
                    // if user is logged in then we present a logout button
                    if $authState.loggedInUser != nil {
                        
                        Button(action: {
                            signoutTapped()
                        }) {
                            Text("SIGN OUT")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(6)
                                .foregroundColor(.white)
                                .padding(10)
                   
                           
                        }
                        
                    } else {
                        // This should work by reading the updated state and displaying a new button for login after logout has been pressed
                        
                        NavigationLink(destination: AuthenticationView(authType:  .login)) {
                            Text("SIGN IN")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(6)
                                .foregroundColor(.white)
                                .padding(10)
                   
                           
                        }
                        
                    }

                }
                
                
            }
            
            .navigationBarTitle("SETTINGS")

        }
    }
    
    
    //-TODO: Add signout button on setting screen
    private func signoutTapped() {
        authState.signout()
        print("sign out button hit")

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
