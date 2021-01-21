//
//  LogoTitleView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct LogoTitleView: View {
    var body: some View {
        
        VStack {
            Image("waveform")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("CD_SAMPLER")
                .font(.title)
                .lineLimit(2)
            
            Text("record/create/share samples")
                .font(.headline)
        }
        .foregroundColor(.white)
        
    }
}

struct LogoTitleView_Previews: PreviewProvider {
    static var previews: some View {
        LogoTitleView()
    }
}
