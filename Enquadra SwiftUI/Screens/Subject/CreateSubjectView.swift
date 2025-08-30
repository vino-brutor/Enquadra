import SwiftUI
import SwiftData

struct CreateSubjectView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var icons: [SubjectIcon] = SubjectIcon.allCases
    let iconsPerRow: Int = 4
    
    @State var subjectName: String = ""
    @State var iconSelected: SubjectIcon?
    @State var showAlert: Bool = false
    @State var isEditing: Bool = false
    
    var subjectToEdit: Subject?
    
    var groupedIcons: [String: [SubjectIcon]] {
        Dictionary(grouping: icons, by: { $0.category })
    }
    
    init(subjectToEdit: Subject? = nil) {
            self.subjectToEdit = subjectToEdit
            _isEditing = State(initialValue: subjectToEdit != nil)
            _subjectName = State(initialValue: subjectToEdit?.name ?? "")
            _iconSelected = State(initialValue: subjectToEdit?.icon)
        }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = UIColor(Color.nublado)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Conteúdo rolável
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Text("Nome da matéria")
                                .font(.body.weight(.semibold))
                                .foregroundStyle(.grafite)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $subjectName)
                                .placeholder(when: subjectName.isEmpty) {
                                    Text("Ex: Matématica")
                                        .foregroundStyle(.areia.opacity(0.3))
                                }
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .font(.body)
                                .foregroundStyle(.sol)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.grafite)
                                )
                            
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            Text("Ícone da matéria:")
                                .padding(.horizontal)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(.grafite)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(groupedIcons.keys.sorted(), id: \.self) { category in
                                VStack(spacing: 8) {
                                    Text(category)
                                        .padding(.horizontal)
                                        .font(.system(.caption2))
                                        .foregroundStyle(.grafite)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    let iconsCategory = groupedIcons[category] ?? []
                                    let iconsRowCount = (iconsCategory.count + iconsPerRow - 1) / iconsPerRow
                                    
                                    ForEach(0..<iconsRowCount, id: \.self) { rowIndex in
                                        HStack(spacing: 20) {
                                            ForEach(0..<iconsPerRow, id: \.self) { columnIndex in
                                                let index = rowIndex * iconsPerRow + columnIndex
                                                
                                                if index < iconsCategory.count {
                                                    let icon = iconsCategory[index]
                                                    
                                                    VStack {
                                                        Image(systemName: icon.rawValue)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(iconSelected == icon ? .grafite : .sol)
                                                            .frame(width: 35, height: 35)
                                                    }
                                                    .frame(width: 75, height: 75)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .foregroundStyle(iconSelected == icon ? .sol : .grafite)
                                                    )
                                                    .overlay( //fazenod bordas com rounded rectangles
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(.grafite, lineWidth: iconSelected == icon ? 8 : 0)
                                                    )
                                                    .onTapGesture { //adicionando ação à stack
                                                        iconSelected = icon
                                                    }
                                                    
                                                } else {
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 50)
                }
                
                // Botão fixo
                VStack {
                    Button {
                        
                        if isEditing, let subjectToEdit {
                            
                            subjectToEdit.name = subjectName
                            subjectToEdit.icon = iconSelected ?? subjectToEdit.icon
                            
                            dismiss()
                        
                        } else {
                            if let iconSelected, !subjectName.isEmpty {
                                
                                let newSubject = Subject(name: subjectName, icon: iconSelected)
                                
                                modelContext.insert(newSubject)
                                
                                dismiss()
                                
                            } else {
                                showAlert = true
                            }
                        }
                

                    } label: {
                        Text(isEditing ? "Editar matéria" : "Criar matéria")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.ceuLimpo)
                            )
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.grafite)
                    }
                    
                    if isEditing {
                        Button {
                            
                            if let subjectToEdit {
                                modelContext.delete(subjectToEdit)
                            }
                            
                            dismiss()
                            
                        } label: {
                            Text("Excluir matéria")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.red)
                                )
                                .font(.body.weight(.semibold))
                                .foregroundStyle(.grafite)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(.nublado)
            }
            .background(.nublado)
            .navigationTitle(isEditing ? "Editar matéria" :"Criar matéria")
            .foregroundStyle(.grafite)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.areia)
                    }
                }
            }
            .alert("Ainda faltam informações!", isPresented: $showAlert) {
                Button(role: .cancel){
                    
                } label: {
                    Text("Ok")
                }
            }
        }
    }
    
    #Preview {
        TabBar()
    }
}
