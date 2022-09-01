//
//  AnimationView.swift
//  DTCodeChallenge
//
//  Created by Dhruvin  on 01/09/22.
//

import SwiftUI

public struct ShimmerView: View {
    
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.mint)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}
