//
//  ScaledText.swift
//  Flashable
//
//  Created by Chris on 7/9/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ScaledText: View {
    @Environment(\.font) var font
    //    @Environment(\.self) var env
    
    private var uiFont: UIFont? {
        switch font {
        case Font.largeTitle:
            return .preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        case Font.title:
            return .preferredFont(forTextStyle: UIFont.TextStyle.title1)
        case Font.headline:
            return .preferredFont(forTextStyle: UIFont.TextStyle.headline)
        case Font.subheadline:
            return .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        case Font.body:
            return .preferredFont(forTextStyle: UIFont.TextStyle.body)
        case Font.callout:
            return .preferredFont(forTextStyle: UIFont.TextStyle.callout)
        case Font.caption:
            return .preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        case Font.footnote:
            return .preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        default:
            for size in 1...1000 {
                if font == Font.system(size: CGFloat(size)) {
                    return UIFont.systemFont(ofSize: CGFloat(size))
                }
            }
        }
        return nil
    }
    
    private let text: String
    private let longestWord: String
    
    @State private var newFont = Font.body
    @State private var isScaled = false
    
    init(_ text: String) {
        self.text = text
        self.longestWord = text.components(separatedBy: .whitespacesAndNewlines).max(by: {$1.count > $0.count}) ?? ""
    }
    
    var body: some View {
        GeometryReader { geometry in
            Text(self.text)
                .font(self.scaledFont(width: geometry.size.width))
//                .minimumScaleFactor(0.01)
        }
    }
    
    func scaledFont(width: CGFloat) -> Font {
        var tmpFont = uiFont ?? .preferredFont(forTextStyle: UIFont.TextStyle.body)
        
        while longestWord.size(withAttributes: [.font: tmpFont]).width > width {
            tmpFont = tmpFont.withSize(tmpFont.pointSize - 1)
        }
        
        return .system(size: tmpFont.pointSize)
    }
}

struct ScaledText_Previews: PreviewProvider {
    static var previews: some View {
        ScaledText("School Superintendents are super cool.")
            .font(.system(size: 100))
            .minimumScaleFactor(0.01)
            .lineLimit(nil)
    }
}
