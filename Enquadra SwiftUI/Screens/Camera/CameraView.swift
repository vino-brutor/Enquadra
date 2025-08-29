//
//  ContentView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 06/08/25.
//

import SwiftUI
import SwiftData

// MARK: - CameraViewRepresentable
// Este struct permite usar uma UIViewController do UIKit dentro do SwiftUI.
// No caso, estamos trazendo a CameraPreviewController para SwiftUI.
struct CameraViewRepresentable: UIViewControllerRepresentable {
    
    // Binding para receber a imagem capturada pela câmera
    @Binding var capturedImage: UIImage?
    
    // Cria a UIViewController do UIKit (CameraPreviewController)
    func makeUIViewController(context: Context) -> CameraPreviewController {
        let controller = CameraPreviewController()
        controller.delegate = context.coordinator // conecta o delegate ao Coordinator
        return controller
    }
    
    // Atualiza a UIViewController caso seja necessário (não usado aqui)
    func updateUIViewController(_ uiViewController: CameraPreviewController, context: Context) { }
    
    // Cria o Coordinator que fará a ponte entre UIKit e SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    // Classe que atua como delegate da CameraPreviewController
    class Coordinator: NSObject, CameraPreviewControllerDelegate {
        var parent: CameraViewRepresentable
        
        init(_ parent: CameraViewRepresentable) {
            self.parent = parent
        }
        
        // Método chamado quando uma foto é capturada
        func didCapturePhoto(_ image: UIImage) {
            // Atualiza o binding da imagem capturada na thread principal
            DispatchQueue.main.async {
                self.parent.capturedImage = image
            }
        }
    }
}

// MARK: - Enum de rotas da câmera
enum cameraRoute {
    case crateSubject // rota para criar uma matéria
    case savePicture  // rota para salvar a foto
}

// MARK: - CameraView
// Tela principal de câmera, mostrando a câmera ativa ou o preview da foto tirada
struct CameraView: View {
    
    // Para dispensar a tela atual (fechar)
    @Environment(\.dismiss) var dismiss
    
    // Query para buscar todas as matérias existentes
    @Query var subjects: [Subject]
    
    // Imagem capturada atualmente
    @State var capturedImage: UIImage?
    
    // Estados de controle da UI
    @State private var showAlertNoSubjectsCreated: Bool = false
    @State private var showSavePictureModal: Bool = false
    @State private var shouldNavigateToCreateSubject = false
    
    var body: some View {
        // NavigationStack permite navegação para outras telas
        NavigationStack {
            
            // Se já existe uma foto capturada, mostramos o preview
            if let image = capturedImage {
                ZStack(alignment: .bottom) {
                    
                    // GeometryReader permite pegar o tamanho da tela para preencher toda a área
                    GeometryReader { geo in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped() // garante que a imagem não vaze da tela
                    }
                    .ignoresSafeArea() // faz a imagem ocupar a tela inteira
                    
                    // HStack do botão "X" para descartar a foto
                    HStack {
                        CircleButton(textButton: "X", isImage: false) {
                            capturedImage = nil
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .padding(4)
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                // HStack com botão de salvar a foto
                HStack {
                    Button {
                        guard capturedImage != nil else { return }
                        
                        if subjects.isEmpty {
                            // Se não houver matérias, mostra alerta
                            showAlertNoSubjectsCreated = true
                        } else {
                            // Caso contrário, abre modal de salvar foto
                            showSavePictureModal = true
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.ceuLimpo)
                                .frame(width: 80, height: 80)
                            
                            VStack {
                                Image(systemName: "square.and.arrow.down")
                                    .symbolRenderingMode(.monochrome)
                                    .font(.system(size: 30).weight(.medium))
                                
                                Text("Salvar")
                                    .font(.system(size: 13).weight(.medium))
                            }
                            .foregroundStyle(.grafite)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, minHeight: 104)
                .background(.grafite.opacity(0.3))
                
            } else {
                // Se não há foto capturada, mostramos a câmera ao vivo
                CameraViewRepresentable(capturedImage: $capturedImage)
                    .ignoresSafeArea(.all)
                
                Spacer()
                
                // Botão para tirar foto
                HStack {
                    Button {
                        NotificationCenter.default.post(name: .takePhotoNotification, object: nil)
                        print(subjects.first?.pictures.first?.picturePath)
                    } label: {
                        Circle()
                            .fill(.ceuLimpo)
                            .frame(width: 80, height: 80)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, minHeight: 104)
                .background(.grafite.opacity(0.3))
            }
        }
        // Configura navegação para criar matéria caso não haja nenhuma
        .navigationDestination(isPresented: $shouldNavigateToCreateSubject) {
            CreateSubjectView()
        }
        // Alerta caso não haja matérias
        .alert("Você não tem nenhuma matéria criada ainda!", isPresented: $showAlertNoSubjectsCreated) {
            Button("Criar matéria", role: .cancel) {
                shouldNavigateToCreateSubject = true
            }
        }
        // Modal para salvar foto
        .sheet(isPresented: $showSavePictureModal) {
            if let image = capturedImage {
                SavePictureView(image: image, isEditing: false)
            }
        }
    }
}

// MARK: - Notification extension
// Nome customizado para notificação de tirar foto
extension Notification.Name {
    static let takePhotoNotification = Notification.Name("takePhotoNotification")
}

// MARK: - Preview
#Preview {
    TabBar()
}
