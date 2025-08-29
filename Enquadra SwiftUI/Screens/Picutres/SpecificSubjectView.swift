//
//  SpecificSubject.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI
import SwiftData

struct SpecificSubjectView: View {
    
    @State var searchableText: String = ""
    let subject: Subject
    @Environment(\.modelContext) var modelContext
    
    var filteredPictures: [Picture] {
        if searchableText.isEmpty {
            return subject.pictures
        } else {
            //pega o nome da foto e ve se contem algum texto de searchble
            return subject.pictures.filter {$0.name.localizedCaseInsensitiveContains(searchableText)}
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("\(filteredPictures.count) conteúdos salvos ")
                        .font(.headline)
                        .foregroundStyle(.areia)
                        .frame(maxWidth: .infinity, alignment: .leading )
                    
                    VStack(spacing: 16){
                        ForEach(filteredPictures) { picture in
                            ContentCard(picture: picture)
                        }
                    }
                }
                
                .padding()
                .navigationTitle(subject.name).toolbarBackground(Color.grafite, for: .navigationBar)
                .searchable(text: $searchableText, prompt: "Procurar conteúdo...")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(.nublado)
            .navigationTitle("")
            
        }
        
    }
}
