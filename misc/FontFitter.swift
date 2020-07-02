//
//  FontFitter.swift
//  Flashable
//
//  Created by Chris on 7/1/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct FontFitter: ViewModifier {
    var font: Font?
    var percent: CGFloat
    var lineWrap: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
        content
            .font(self.font == nil ? .system(size: geometry.size.height * self.percent) : self.font!)
            .minimumScaleFactor(0.0001)
            .lineLimit(self.lineWrap ? nil : 1)
            .frame(width: geometry.size.width * self.percent, height: geometry.size.height * self.percent)
        }
    }
}

extension View {
    func fitFont(font: Font? = nil, percent: CGFloat = 1.0, lineWrap: Bool = true) -> some View {
        self.modifier(FontFitter(font: font, percent: percent, lineWrap: lineWrap))
    }
}
