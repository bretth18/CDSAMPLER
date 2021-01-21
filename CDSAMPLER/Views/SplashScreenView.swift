//
//  SplashScreenView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct SplashScreenView: View {
    
    // temp, lets use colors and gradients instead
//    let imageName: String
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .top, endPoint: .bottom)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
