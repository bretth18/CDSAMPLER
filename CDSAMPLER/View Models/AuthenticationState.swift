//
//  AuthenticationState.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation
import FirebaseAuth
import Combine
import AuthenticationServices


// enum for signin cases
enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}


// Singleton class that inherits NSObject and implements ObservableObject protocol
class AuthenticationState: NSObject, ObservableObject {
    
    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    
    
    static let shared = AuthenticationState()
    
    private let auth = Auth.auth()
    fileprivate var currentNonce: String?
    
    
    // Login
    func login(with loginOption: LoginOption) {
        
        self.isAuthenticating = true
        self.error = nil
        
        switch loginOption {
            case .signInWithApple:
                handleSignInWithApple()
                
        case let .emailAndPassword(email, password):
            handleSignInWith(email: email, password: password)
        }
        
    }
    
    
    // Signout
    // Triggers the authStateDidChangeListener and sets the value of authenticated user to nil
    // This triggers the authenticationstate change that will render the authentication view, replacing our main view
    func signout() {
        do {
            try auth.signOut()
            print("signing out...")
            
            // trying this?
            self.loggedInUser = nil
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    // Signup
    func signup(email: String, password: String, passwordConfirmation: String) {
        
        // Check that passwords match
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation does not match"])
            return
        }
        
        self.isAuthenticating = true
        self.error = nil
        
        // create user
        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
        
    }
    

        
    
    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        
        //-NOTE: not sure if dispatch queue on the main thread should be used here
        
        DispatchQueue.main.async {
            self.isAuthenticating = false
                
            if let user = auth?.user {
                self.loggedInUser = user
                
            } else if let error = error {
                self.error = error as NSError
            }
        }
    }
    
}


// Extension allows for implementation of Sign In With Apple

extension AuthenticationState: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    
    // Func
    private func handleSignInWithApple() {
        
        // Generate random nonce string and store it into currentNonce
        let nonce = String.randomNonceString()  // NEEDS EXTENSION
        currentNonce = nonce
        
        // Create ASAuthorizationAppleIDProvider and request, setting request scope to retrieve email and full name. nonce string is passed with a SHA-256 hash
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.sha256
        
        // Initialize ASAuthorizationController, passing the request
        // Set the delegate and presentatonContextProvider to the AuthenticationState
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    
    // 2
    // We need to return the anchor, so we're using AppDelegate to use the first window as the anchor for presentation
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows[0]
    }
    
    // 3
    // Function retrieves the credential and id token from ASAuthorizationAppleIDCredential, constructs the OAuth credential using apple.com as the provider id and passes the token and nonce string. FirebaseAuth is used to sign in, passing the credential and completion closure
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("INVALID STATE: A login callback was received but no login request was sent")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            
            // Initialize a Firebase credential here
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            // Sign in with firebase using credential
            Auth.auth().signIn(with: credential, completion: handleAuthResultCompletion)
            
        }
    }
    
    
    // 4
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print ("Sign in with Apple error: \(error)")
        
        self.isAuthenticating = false
        self.error = error as NSError
    }
    
    
}
