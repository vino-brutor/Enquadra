//
//  SucjectsIcons.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 07/08/25.
//

import Foundation

enum SubjectIcon: String, CaseIterable, Identifiable, Codable {
    
    // FACULDADE
    case graduationCap = "graduationcap.fill"
    case books = "books.vertical.fill"
    case eraser = "eraser.fill"
    case bookClosed = "book.closed.fill"
    case chart = "chart.bar.xaxis"
    case pencil = "pencil"
    case pencilOutline = "pencil.tip"
    case notebook = "book"
    
    // MATEMÁTICA
    case function = "function"
    case plusMinus = "plus.slash.minus"
    case numberList = "list.number"
    case percent = "percent"
    case chartBar = "chart.bar"
    case chartLine = "chart.line.uptrend.xyaxis"
    case sum = "sum"
    case squareRoot = "x.squareroot"
    
    // COMPUTAÇÃO
    case desktop = "desktopcomputer"
    case laptop = "laptopcomputer"
    case terminal = "terminal"
    case code = "chevron.left.slash.chevron.right"
    case server = "server.rack"
    case cpu = "cpu"
    case lockShield = "lock.shield"
    case network = "dot.radiowaves.left.and.right"
    
    // BIOLÓGICAS
    case dna = "atom"
    case microscope = "cat.fill"
    case leaf = "leaf"
    case heart = "heart.fill"
    case lungs = "lungs.fill"
    case pill = "pills.fill"
    case drop = "drop.fill"
    case stethoscope = "stethoscope"
    
    // HUMANAS
    case globe = "globe"
    case bookOpen = "book.fill"
    case figureWalk = "figure.walk"
    case figureSpeaking = "person.wave.2.fill"
    case theaterMasks = "theatermasks.fill"
    case newspaper = "newspaper.fill"
    case brain = "brain.head.profile"
    case megaphone = "megaphone.fill"
    
    var id: String {
        rawValue
    }
    
    var category: String {
        switch self {
        case .graduationCap, .books, .eraser, .bookClosed, .chart, .pencil, .pencilOutline, .notebook:
                    return "Faculdade"
                case .function, .plusMinus, .numberList, .percent, .chartBar, .chartLine, .sum, .squareRoot:
                    return "Matemática"
                case .desktop, .laptop, .terminal, .code, .server, .cpu, .lockShield, .network:
                    return "Computação"
                case .dna, .microscope, .leaf, .heart, .lungs, .pill, .drop, .stethoscope:
                    return "Biológicas"
                case .globe, .bookOpen, .figureWalk, .figureSpeaking, .theaterMasks, .newspaper, .brain, .megaphone:
                    return "Humanas"
        }
    }
}
