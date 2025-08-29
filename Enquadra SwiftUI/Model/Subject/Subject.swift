//
//  Materia.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 07/08/25.
//

import Foundation
import SwiftData

@Model
final class Subject {
    var id: UUID = UUID()
    var name: String
    var icon: SubjectIcon
    
    @Relationship(deleteRule: .cascade, inverse: \Picture.subject)
    var pictures: [Picture] = []
    
    init(name: String, icon: SubjectIcon) {
        self.name = name
        self.icon = icon
    }
}
