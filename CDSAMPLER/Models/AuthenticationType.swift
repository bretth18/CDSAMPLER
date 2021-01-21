//
//  AuthenticationType.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation

enum AuthenticationType: String {
    
    case login
    case signup
    
    var text: String {
        rawValue.capitalized
    }
    
    var assetBackgroundName: String {
        self == .login ? "login" : "signup"
    }
    
    var footerText: String {
        switch self {
            case .login:
                return "No account, signup!"
            
            case .signup:
                return "Already have an account? login!"
        }
    }
}


