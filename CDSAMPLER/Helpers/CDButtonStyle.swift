//
//  CDButtonStyle.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation
import SwiftUI


// Implements ButtonStyle protocol
struct CDButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            
            // Using both overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(currentForegroundColor, lineWidth: 1))
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
        

    }
}
