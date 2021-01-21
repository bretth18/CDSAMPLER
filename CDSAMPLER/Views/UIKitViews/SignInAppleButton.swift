//
//  SignInAppleButton.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct SignInAppleButton: UIViewRepresentable {
    
    let action: () -> ()
    
    func makeUIView(context: UIViewRepresentableContext<SignInAppleButton>) -> ASAuthorizationAppleIDButton {
        
        ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<SignInAppleButton>) {
        
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped(_:)), for: .touchUpInside)
    }
    
    
    func makeCoordinator() -> SignInAppleButton.Coordinator {
        Coordinator(action: self.action)
    }
    
    
    class Coordinator {
        
        let action: () -> ()
        
        init(action: @escaping() -> ()) {
            self.action = action
        }
        
        @objc fileprivate func buttonTapped(_ sender: Any) {
            action()
        }
    }
}
