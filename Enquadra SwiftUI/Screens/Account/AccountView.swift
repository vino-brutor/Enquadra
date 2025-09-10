//
//  AccountView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    
    @Binding var tabSelection: Int
    @Query() var subjects: [Subject]
    let barColors: [Color] = [.ceuLimpo, .sol, .areia, .raios, .grafite]
    var sortedSubjects: [Subject] {
        let subjectSorted = subjects.sorted {$0.pictures.count > $1.pictures.count}
        
        return Array(subjectSorted.prefix(5))
    }
    
    var maxCount: Int { return sortedSubjects.map {$0.pictures.count}.max() ?? 0
    }
    
    var body: some View {
        
        if subjects.isEmpty {
            VStack (spacing: 16){
                Image(.customEmptyData)
                Text("Não temos nenhum dado pra mostrar, quem sabe tirar foto de alguns conteúdos para comecar a ver?")
                    .font(.callout)
                    .foregroundStyle(.metal)
                    .multilineTextAlignment(.center)
                
                Button() {
                    tabSelection = 2
                } label : {
                    Text("Tirar nova foto")
                        .foregroundStyle(.grafite)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.ceuLimpo)
                )
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.nublado)
            .navigationTitle("Estatísticas")
        } else {
            ScrollView {
                VStack(alignment: .leading,spacing: 16){
                    
                    Text("Quantidade de conteúdos")
                        .font(.system(size: 22).bold())
                        .foregroundStyle(.grafite)
                    
                    VStack(spacing: 16){
                        ForEach(Array(sortedSubjects.enumerated()), id: \.element) { index, subject in
                            
                            progressBarSubject(subject: subject, maxCount: maxCount, count: subject.pictures.count, color: barColors[index])
                            
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
    
}

#Preview {
    //AccountView()
}
