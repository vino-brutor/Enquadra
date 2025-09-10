//
//  MateriasView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 07/08/25.
//

import SwiftUI
import SwiftData

struct SubjectsView: View {
    
    @State var showNewSubjectSheet = false
    @Query var subjects: [Subject]
    @State var editingSubject: Subject? = nil
    
    var body: some View {
        NavigationStack {
            
            if subjects.isEmpty {
                VStack(spacing: 16){
                    
                    Spacer()
                    
                    Image(.customEmptyIcon)
                    Text("Nenhuma matéria criada ainda, quando você criar uma ela aparecerá aqui!")
                        .font(.callout)
                        .foregroundStyle(.metal)
                        .multilineTextAlignment(.center)
                    Button() {
                        showNewSubjectSheet = true
                    } label : {
                        Text("Criar matéria")
                            .foregroundStyle(.grafite)
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.ceuLimpo)
                    )
                    
                    Spacer()
                    
                }
                .padding(32)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.nublado)
                .navigationTitle("Matérias")
                .sheet(isPresented: $showNewSubjectSheet) {
                    CreateSubjectView()
                }
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(subjects) { subject in
                            NavigationLink {
                                SpecificSubjectView(subject: subject)
                            } label: {
                                SubjectCard(
                                    subjectName: subject.name,
                                    subjectIcon: subject.icon
                                ) {
                                    editingSubject = subject
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(.nublado)
                .navigationTitle("Matérias")
                // Removidos os modificadores de toolbar
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showNewSubjectSheet = true
                            print(subjects)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showNewSubjectSheet) {
                    CreateSubjectView()
                }
                .sheet(item: $editingSubject){ subject in
                    CreateSubjectView(subjectToEdit: subject)
                }
                .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    TabBar()
}
