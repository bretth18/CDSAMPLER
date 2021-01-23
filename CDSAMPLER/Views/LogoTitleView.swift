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
            Image(systemName: "waveform")
                .foregroundColor(.white)
                .font(.largeTitle)
                .frame(width: 180, height: 180)
            
            Text("CD_SAMPLER")
                .font(.largeTitle)
                .fontWeight(.black)
                .lineLimit(1)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                
            
            
            Text("record/create/share samples")
                .font(.headline)
        }
        .foregroundColor(.white)
        
        
    }
}

struct LogoTitleView_Previews: PreviewProvider {
    static var previews: some View {
        

        
        LogoTitleView()
            .background(Color.black ).ignoresSafeArea()
    }
}
