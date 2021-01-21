//
//  ContentView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    
    var body: some View {
        Group {
            if authState.loggedInUser != nil {
                SamplerView()
            } else {
                
                AuthenticationView(authType: .login)
            }
        }
        .animation(.easeInOut)
        .transition(.move(edge: .bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
