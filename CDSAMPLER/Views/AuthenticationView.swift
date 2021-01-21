//
//  AuthenticationView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    @State var authType = AuthenticationType.login
    
    
    
    var body: some View {
        
        ZStack {
            SplashScreenView()
            
            VStack(spacing: 32) {
                
                LogoTitleView()
                
                if (!authState.isAuthenticating) {
                    AuthenticationFormView(authType: $authType)
                } else {
                    ProgressView()
                }
                
                
                SignInAppleButton {
                    self.authState.login(with: .signInWithApple)
                }
                .frame(width: 130, height: 44)
            }
            .offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
        }
      
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
