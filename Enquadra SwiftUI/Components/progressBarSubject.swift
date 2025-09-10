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
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("\(subject.name)")
                    .font(.headline)
                    .foregroundStyle(.grafite)
                
                Spacer()
                
                Text("\(subject.pictures.count)")
                    .font(.headline)
                    .foregroundStyle(.grafite)
            }
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 15)
                    .foregroundColor(.metal.opacity(0.3))
                
                if maxCount > 0 {
                    
                    let ratio = CGFloat(count) / CGFloat(maxCount)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: ratio * UIScreen.main.bounds.width - 80, height: 15)
                        .foregroundColor(color)
                }
                    
            }
        }
    }
}
