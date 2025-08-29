//
//  Picture.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import Foundation
import SwiftData

@Model
class Picture {
    var id = UUID()
    var name: String
    var date: Date
    var picturePath: String
    
    var subject: Subject
    
    init(name: String, picturePath: String, date: Date = Date(), subject: Subject) {
        self.name = name
        self.picturePath = picturePath
        self.date = date
        self.subject = subject
    }
    
}
