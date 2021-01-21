//
//  StringExtensions.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation
import CryptoKit


extension String {
    
    
    var sha256: String {
        
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
    // Modified from Auth0 docs
    static func randomNonceString(length: Int = 32) -> String {
        
        precondition(length > 0)
        
        
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        var result = ""
        var remainingLength = length
        
        
        while remainingLength > 0 {
            
            let randoms: [UInt8] = (0..<16).map { _ in
                
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                
                return random
            }
            
            randoms.forEach { random in
                
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}
