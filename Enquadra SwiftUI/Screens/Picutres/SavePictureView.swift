import SwiftData
import SwiftUI

struct SavePictureView: View {
    let image: UIImage
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var subjects: [Subject]
    
    @State var showAlertNoSelectedSubjects: Bool = false
    @State var selectedSubject: Subject?
    @State var pictureTitle: String = ""
    @State var isLoading: Bool = false
    @State var isEditing: Bool
    
    @FocusState var isKeyboardFocused: Bool //State pra fazer com que o teclado saia da tela
    
    var pictureToEdit: Picture?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Imagem principal
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 361, height: 361)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Bloco de informações e botões
                    VStack(spacing: 16) {
                        
                        // Título da seção
                        Text("Informações do conteúdo")
                            .font(.system(size: 24).weight(.bold))
                            .foregroundStyle(.grafite)
                            .frame(maxWidth: .infinity ,alignment: .leading)
                        
                        // Menu de seleção de matéria
                        Menu {
                            ForEach(subjects) { subject in
                                Button {
                                    selectedSubject = subject
                                } label: {
                                    Label(subject.name, systemImage: subject.icon.rawValue)
                                }
                            }
                        } label: {
                            HStack {
                                if let selected = selectedSubject {
                                    HStack(spacing: 12) {
                                        Image(systemName: pictureToEdit?.subject.icon.rawValue ?? selected.icon.rawValue)
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .foregroundStyle(.argila)
                                            )
                                        
                                        Text("Matéria")
                                            .foregroundStyle(.nublado)
                                        
                                        Spacer()
                                        
                                        Text(pictureToEdit?.subject.name ?? selected.name)
                                            .foregroundColor(.sol)
                                    }
                                } else {
                                    Text("Selecionar Matéria")
                                        .foregroundColor(.sol)
                                }
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.sol)
                            }
                            .padding(.vertical, 6.75)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.grafite)
                            )
                        }
                        
                        
                        // Campo de título
                        TextField(pictureToEdit?.name ?? "Título", text: $pictureTitle)
                            .focused($isKeyboardFocused) //colcoa o atributo focused pra tirar o tecaldo da tela
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.grafite)
                            )
                            .font(.body.weight(.regular))
                            .foregroundStyle(.sol)
                        
                        // Botão de salvar/editar
                        Button {
                            if let pictureToEdit, !pictureTitle.isEmpty, let subject = selectedSubject {
                                pictureToEdit.name = pictureTitle
                                pictureToEdit.subject = subject
                                dismiss()
                            } else {
                                guard let subject = selectedSubject else {
                                    showAlertNoSelectedSubjects = true
                                    return
                                }
                                
                                if let fileName = PictureStorage.saveImage(image: image) {
                                    let picture = Picture(
                                        name: pictureTitle.isEmpty ? "foto \(Date())" : pictureTitle,
                                        picturePath: fileName,
                                        subject: subject
                                    )
                                    modelContext.insert(picture)
                                    
                                    do {
                                        try modelContext.save()
                                        dismiss()
                                    } catch {
                                        print("Erro ao tentar salvar no banco: \(error)")
                                    }
                                }
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.ceuLimpo)
                                .frame(height: 50)
                                .overlay(
                                    Text(pictureToEdit != nil ? "Editar conteúdo" : "Salvar conteúdo")
                                        .font(.body.bold())
                                        .foregroundColor(.grafite)
                                )
                        }
                        .padding(.top, 42)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 45)
            }
            .background(Color.nublado.ignoresSafeArea())
            .navigationTitle("Salvar conteúdo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.areia)
                    }
                }
            }
            .alert("Selecione uma matéria antes de salvar.", isPresented: $showAlertNoSelectedSubjects) {
                Button("OK", role: .cancel) {}
            }
            .onAppear {
                if let pictureToEdit {
                    self.pictureTitle = pictureToEdit.name
                    self.selectedSubject = pictureToEdit.subject
                } else if selectedSubject == nil {
                    selectedSubject = subjects.first
                }
            }
            .onTapGesture {
                isKeyboardFocused = false
            }
        }
    }
}
