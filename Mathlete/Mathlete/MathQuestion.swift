//
//  Question.swift
//  Mathlete
//
//  Created by Chris on 4/15/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import Foundation

protocol Question {
    var text: String { get }
    var answer: String { get }
}


enum Operator: String, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
}


struct MathQuestion: Question {
    let terms: [Int]
    let op: Operator
    
    var text: String {
        "\(terms[0]) \(op.rawValue) \(terms[1])"
    }
    
    var answer: String {
        switch op {
        case .add:
            return String(terms[0] + terms[1])
        case .subtract:
            return String(terms[0] - terms[1])
        case .multiply:
            return String(terms[0] * terms[1])
        case .divide:
            return String(terms[0] / terms[1])
        }
    }
}

