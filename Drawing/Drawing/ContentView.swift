//
//  ContentView.swift
//  Drawing
//
//  Created by Chris on 4/20/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        //path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    // Doesn't need metal
                    //.strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    // Needs metal
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}


struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(rows), Double(columns))
        }

        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}


// Challenge 1.
struct Arrow: InsettableShape {
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let insetRect = rect.inset(by: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))
        
        let headLength = insetRect.height * 0.33
        let stemLength = insetRect.height - headLength
        let stemWidth = insetRect.width * 0.25
        
        var path = Path()
        path.move(to: CGPoint(x: insetRect.midX, y: insetRect.minY))
        path.addLine(to: CGPoint(x: insetRect.maxX, y: insetRect.minY + headLength))
        path.addLine(to: CGPoint(x: insetRect.minX, y: insetRect.minY + headLength))
        path.addLine(to: CGPoint(x: insetRect.midX, y: insetRect.minY))
        path.addRect(CGRect(x: insetRect.midX - stemWidth / 2, y: insetRect.minY + headLength, width: stemWidth, height: stemLength))
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var insetArrow = self
        insetArrow.insetAmount += amount
        
        return insetArrow
    }
}


struct ContentView: View {
//    @State private var petalOffset = -20.0
//    @State private var petalWidth = 100.0
//
//    @State private var colorCycle = 0.0
//
    @State private var amount: CGFloat = 0.0
//
//    @State private var insetAmount: CGFloat = 50
//
//    @State private var rows = 4
//    @State private var columns = 4
    
    @State private var lineThickness: CGFloat = 10
    
    var body: some View {
//        // 1.
//        Path { path in
//            path.move(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
//            //path.addLine(to: CGPoint(x: 100, y: 300))
//        }
//        //.fill(Color.blue)
//        //.stroke(Color.blue, lineWidth: 10)
//        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    
        
//        // 2.
//        Triangle()
//            //.fill(Color.red)
//            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
        
        
        // 3.
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//        .stroke(Color.blue, lineWidth: 10)
//        .frame(width: 300, height: 300)
        
        
        // 4.
//        Circle()
//        .strokeBorder(Color.blue, lineWidth: 40)
        
//        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
//        .strokeBorder(Color.blue, lineWidth: 40)
        
        // 5. Transforms
//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                //.stroke(Color.red, lineWidth: 1)
//                .fill(Color.red, style: FillStyle(eoFill: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//        }
        
        
        // 6. ImagePaint
//        VStack {
//            Text("Hello World")
//                .frame(width: 200, height: 200)
//                .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
//            //.border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//
//            Capsule()
//                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
//                .frame(width: 300, height: 200)
//        }
        
        
        // 7. Metal
//        VStack {
//            ColorCyclingCircle(amount: self.colorCycle)
//                .frame(width: 300, height: 300)
//
//            Slider(value: $colorCycle)
//        }
        
        
        // 8. Special effects: blending 1
//        Image("Example")
//            .resizable()
//            .edgesIgnoringSafeArea(.all)
//            .scaledToFill()
//            .offset(x: -150, y: 0)
//            .colorMultiply(.red)
        
        
        // 8. Special effects: blending 2, blurs, saturation
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 200, height: 300)

            Image("Example")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .saturation(Double(amount))
            .blur(radius: (1 - amount) * 20)

            Slider(value: $amount)
                .padding()
            
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
        
        // 9. Animating simple shapes: animatableData
//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                withAnimation {
//                    self.insetAmount = CGFloat.random(in: 10...90)
//                }
//            }
        
        
        // 10. Animating complex shapes with AnimatablePair
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    self.rows = 8
//                    self.columns = 16
//                }
//            }
        
        // Challenge 1.
        Arrow()
            //.fill(Color.blue)
            .strokeBorder(Color.red, style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
            .contentShape(Rectangle()) // make entire area tappable
            .onTapGesture {
                withAnimation {
                    self.lineThickness = CGFloat.random(in: 10...90)
                }
            }
            
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
