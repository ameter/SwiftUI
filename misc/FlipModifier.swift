//
//  FlipModifier.swift
//  FlipModifierDemo
//
//  Created by Chris on 7/21/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI


struct FlipModifier<FlippedContent>: AnimatableModifier where FlippedContent: View{
    var rotation: Double
    
    var isFlipped: Bool {
        rotation > 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    var axis: (x: CGFloat, y: CGFloat, z:CGFloat)
    
    var flippedContent: () -> FlippedContent
    
    init(isFlipped: Bool, axis: (x: CGFloat, y: CGFloat, z: CGFloat), flippedContent: @escaping () -> FlippedContent) {
        rotation = isFlipped ? 180 : 0
        self.flippedContent = flippedContent
        self.axis = axis
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(isFlipped ? 0 : 1)
            
            flippedContent()
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(Angle.degrees(180), axis: axis)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: axis)
    }
}

extension View {
    func flip<FlippedContent>(when: Bool, axis: (x: CGFloat, y: CGFloat, z: CGFloat), @ViewBuilder flippedContent: @escaping () -> FlippedContent) -> some View where FlippedContent: View {
        self.modifier(FlipModifier(isFlipped: when, axis: axis, flippedContent: flippedContent))
    }
}

