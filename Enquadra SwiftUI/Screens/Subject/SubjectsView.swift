//
//  MateriasView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 07/08/25.
//

import SwiftUI
import SwiftData

struct SubjectsView: View {
    
    @State var showNewSubjectSheet = false
    @Query var subjects: [Subject]
    @State var editingSubject: Subject? = nil
    
    
//    init() {
//        let appearance = UINavigationBarAppearance()
//        
//        appearance.titleTextAttributes = [
//            .foregroundColor: UIColor(Color.grafite),
//        ]
//        
//        appearance.largeTitleTextAttributes = [
//                .foregroundColor: UIColor(Color.grafite)
//            ]
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
    
    var body: some View {
        NavigationStack {
            
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
            .sheet(item: $editingSubject){ subject in
                CreateSubjectView(subjectToEdit: subject)
            }
            .background(.nublado)
            .navigationTitle("Matérias")
            .toolbarBackground(.nublado, for: .navigationBar)
            .toolbarVisibility(.visible, for: .tabBar)
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
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TabBar()
}
