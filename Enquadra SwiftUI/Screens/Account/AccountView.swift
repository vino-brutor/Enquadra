//
//  AccountView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    
    @Query() var subjects: [Subject]
    var sortedSubjects: [Subject] {
        var subjectSorted = subjects.sorted {$0.pictures.count > $1.pictures.count}
        
        return Array(subjectSorted.prefix(5))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 16){
                
                Text("Quantidade de conteúdos")
                    .font(.system(size: 22).bold())
                    .foregroundStyle(.grafite)
                
                VStack(spacing: 16){
                    ForEach(sortedSubjects, id: \.self) { subject in
                        
                        var maxCount = sortedSubjects.map {$0.pictures.count}.max() ?? 0
                        
                        progressBarSubject(subject: subject, maxCount: maxCount, count: subject.pictures.count)
                    }
                }
                
            }
            .navigationTitle("Estatísticas")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        .background(Color.nublado)
    }
}

#Preview {
    AccountView()
}
