//
//  progressBarSubject.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 30/08/25.
//

import SwiftUI

struct progressBarSubject: View {
    
    var subject: Subject
    var maxCount: Int
    var count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("\(subject.name) - \(subject.pictures.count) ")
                .font(.headline)
                .foregroundStyle(.grafite)
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 15)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: CGFloat(count / maxCount) * UIScreen.main.bounds.width - 80, height: 15)
                    .foregroundColor(.ceuLimpo)
                    
            }
        }
    }
}
