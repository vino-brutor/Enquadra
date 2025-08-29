import SwiftUI

struct ContentCard: View {
    
    let picture: Picture
    @Environment(\.modelContext) var modelContext
    @State var showEdit: Bool = false
    @State var showConfirmDialog: Bool = false
    
    
    var body: some View {
        NavigationLink{
            
            SendPicutreView(picture: picture)
            
        } label: {
            
            HStack(spacing: 16) {
                
                if let image = PictureStorage.loadImage(fileName: picture.picturePath) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped()
                    
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundStyle(.white)
                        )
                }
                
                VStack(alignment: .leading) {
                    Text(picture.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.grafite)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(picture.date, format: .dateTime.day().month().year()) // formata a data
                        .font(.system(size: 14))
                        .foregroundStyle(.argila)
                }
                .padding(.leading, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .padding()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.sol)
                    .font(.system(.body).weight(.semibold))
                    .onTapGesture {
                        showConfirmDialog = true
                    }
                    .confirmationDialog("Opções", isPresented: $showConfirmDialog){
                        Button("Editar", systemImage: "square.and.pecil") {
                            print("clicado")
                            showEdit = true
                        }
                        Button("Excluir", systemImage: "trash", role: .destructive) {
                            PictureStorage.deleteImage(fileName: picture.picturePath)
                            modelContext.delete(picture)
                            
                            do{
                                try modelContext.save()
                            } catch {
                                print("não foi possivel atualizar na hora")
                            }
                        }
                    }
                
                
            }
            .frame(height: 82)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ceuLimpo.opacity(0.8)) // cor de fundo
            )
            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            .sheet(isPresented: $showEdit ) {
                if let pictureUIImage = PictureStorage.loadImage(fileName: picture.picturePath) {
                    SavePictureView(image: pictureUIImage ,isEditing: true, pictureToEdit: picture)
                }
            }
            
        }
    }
}

//#Preview {
//    ContentCard(
//        picture: Picture(
//            name: "Vetores aula 1",
//            picturePath: "fake.jpg",
//            date: Date(),
//            subject: nil
//        )
//    )
//}
