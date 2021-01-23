//
//  AuthenticationFormView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct AuthenticationFormView: View {
    
    // Used to invoke login and signup method passing the correct params. Error property is used to display alert sheet containing the error message
    @EnvironmentObject var authState: AuthenticationState
    
    // Text field bindings
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""
    @State var isShowingPassword = false
    
    // Determine the text value of buttons and show additional fields for signup state
    @Binding var authType: AuthenticationType
    
    
    var body: some View {
        
        // 1
        VStack(spacing: 16) {
            
            // 2
            
            TextField("EMAIL", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none  )
            
            // 3
            if isShowingPassword {
                TextField("PASSWORD", text: $password)
                    .textContentType(.password)
                    .autocapitalization(.none)
                
            } else {
                SecureField("PASSWORD", text: $password)
            }
            
            // 4
            if authType == .signup {
                
                if isShowingPassword {
                    TextField("PASSWORD CONFIRMATION", text: $passwordConf)
                        .textContentType(.password)
                        .autocapitalization(.none)
                } else {
                    SecureField("PASSWORD CONFIRMATION", text: $passwordConf)
                    
                }
            }
            
            
            // 5
            Toggle("SHOW PASSWORD", isOn: $isShowingPassword)
                .foregroundColor(.white)
            
            // 6
            Button(action: emailAuthenticationTapped) {
                Text(authType.text)
                    .font(.callout)
            }
            .buttonStyle(CDButtonStyle(backgroundColor: .black, foregroundColor: .white, isDisabled: false))
            .frame(width: 200, height: 50)
            .disabled(email.count == 0 && password.count == 0)
            
            
            // 7
            Button(action: footerButtonTapped) {
                Text(authType.footerText)
                    .font(.callout)
            }
            .foregroundColor(.white)
            
            
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 288)
        
        // 8
        .alert(item: $authState.error) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription))
        }
        
        
    }
    
    
    private func emailAuthenticationTapped() {
        
        switch authType {
        case .login:
            authState.login(with: .emailAndPassword(email: email, password: password))
        case .signup:
            authState.signup(email: email, password: password, passwordConfirmation: passwordConf)
        }
    }
    
    private func footerButtonTapped() {
        clearFormField()
        authType = authType == .signup ? .login : .signup
    }
    
    private func clearFormField() {
        email = ""
        password = ""
        passwordConf = ""
        isShowingPassword = false
    }
}



struct AuthenticationFormViewPreviewContainer: View {
    @State private var value = AuthenticationType.login
    
    var body: some View {
        AuthenticationFormView(authType: $value)
    }
}

#if DEBUG
struct AuthenticationFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthenticationFormViewPreviewContainer()
    }
}
#endif
