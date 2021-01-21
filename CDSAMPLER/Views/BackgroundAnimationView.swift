//
//  BackgroundAnimationView.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import SwiftUI

struct BackgroundAnimationView: View {
    
    
    @State private var showSmallest = false
    @State private var showSmaller = false
    @State private var showSmall = false
    @State private var showLarge = false
    @State private var showLarger = false
    @State private var showLargest = false
    @State private var showCentral = false
    
    var body: some View {
        
        
        ZStack {
                    Circle() // Largest
                        .stroke(lineWidth: 2.0)
                        .frame(width: 300, height: 300, alignment: .center)
                        .foregroundColor(Color.white)
                        .scaleEffect(showLargest ? 4 : 0.5)
                        .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showLargest.toggle()
                        }
                    
                    Circle() // Larger
                        .stroke(lineWidth: 2.0)

                        .frame(width: 250, height: 250, alignment: .center)
                        .foregroundColor(Color.white)
                        .scaleEffect(showLarger ? 1 : 0.5)
                        .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showLarger.toggle()
                        }
                    
                    Circle() // Large
                        .stroke(lineWidth: 2.0)

                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(Color.white)
                        .scaleEffect(showLarge ? 4 : 0.5)
                        .animation(Animation.easeOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showLarge.toggle()
                        }
                    
                    Circle() // Small
                        .stroke(lineWidth: 2.0)

                        .frame(width: 150, height: 150, alignment: .center)
                        .foregroundColor(Color.white)
                        .opacity(showSmall ? 4 : 0.1)
                        .scaleEffect(showSmall ? 1 : 0.5)
                        .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showSmall.toggle()
                        }
                    
                    Circle() // Smaller
                        .stroke(lineWidth: 2.0)

                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color.white)
                        .opacity(showSmaller ? 1 : 0.1)
                        .scaleEffect(showSmaller ? 4 : 0.5)
                        .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showSmaller.toggle()
                        }
                    
                    Circle() // Smallest
                        .stroke(lineWidth: 2.0)

                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color.white)
                        .opacity(showSmallest ? 1 : 0.1)
                        .scaleEffect(showSmallest ? 4 : 0.5)
                        .animation(Animation.easeOut(duration: 8).repeatForever(autoreverses: true))
                        .onAppear(){
                            showSmallest.toggle()
                        }
                    
                    Circle()
                        .stroke(lineWidth: 2.0)

                        .frame(width: 12.5, height: 12.5, alignment: .center)
                        .opacity(showCentral ? 1 : 0.1)
                        .scaleEffect(showCentral ? 1 : 0.8)
                        .animation(Animation.easeOut(duration: 4).repeatForever(autoreverses: true))
                        .onAppear(){
                            showCentral.toggle()
                        }
                        
                }
        .opacity(0.2)
        
    }
}

struct BackgroundAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimationView()
    }
}
