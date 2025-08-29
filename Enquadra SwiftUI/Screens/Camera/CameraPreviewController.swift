//
//  CameraPreviewController.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import Foundation
import SwiftUI
import AVFoundation

class CameraPreviewController: UIViewController {
    
    //cria uma sessão de captura, onde podemos mexer nos inputs, opcional pq só criada no setup
    var captureSession: AVCaptureSession?
    var photoOutput = AVCapturePhotoOutput() //cria um output pras fotos
    var delegate: CameraPreviewControllerDelegate? //cria um delegate pra nossa classe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTakePhotoNotification), name: .takePhotoNotification, object: nil)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gesture: )))
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinch(gesture: UIPinchGestureRecognizer) {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        
        do {
            try device.lockForConfiguration()
            
            let zoom = max(1.0, min(device.activeFormat.videoMaxZoomFactor, gesture.scale * device.videoZoomFactor))
            device.videoZoomFactor = zoom
            
            device.unlockForConfiguration()
            
        } catch {
            print("Erro ao dar zoom na camera")
        }
        
        if gesture.state == .ended || gesture.state == .cancelled {
               gesture.scale = 1.0
           }
    }
    
    @objc func handleTakePhotoNotification() {
        takePhoto()
    }
    //função para deixar o usuário dar zoom
    
    
    func checkPermission(){
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authorizationStatus {
        case .authorized: //se o status for autorizado incia o seutp da camera pra usar o app
            setCaptureSession()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){ granted in //pede a autirzacao se ainda n tiver pedido
                if granted{
                    self.setCaptureSession()
                } else {
                    self.showPermissionAlert()
                }
            }
            
        case .denied, .restricted:
            showPermissionAlert()
            
        default:
            showPermissionAlert()
        }
        
    }
    
    func showPermissionAlert(){
        let alert = UIAlertController(
            title: "Permissão necessária",
            message: "Ative o acesso à câmera nas Configurações para usar esta função.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func setCaptureSession(){
        //cria sessão local pra configurar as coisas
        let session = AVCaptureSession()
        
        session.sessionPreset = .photo //define a qualidade da sessao, .photo pega a maior possivel
        
        //o AVCapture device pega a camre do dispositivo, no caso escolhemos builtInWideAngleCamera traseira (.back)
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device), //a partir do device, cria um captureDeviceInput, pra pdoer tirar as fotos
              session.canAddInput(input), //verifica se o input é compativel com a sessao
              session.canAddOutput(photoOutput)
        else {return}
        
        session.addInput(input) //agora a sessao sabe que a camera existe
        
        session.addOutput(photoOutput) //adiciona o output
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session) //cria uma camada de preview a partir da sessao que configuramos
        
        previewLayer.videoGravity = .resizeAspectFill //videoGravity indica como o preview vai aparecer na tela (cortado ou inteiro)
        
        previewLayer.frame = view.bounds //prende a layer no comprimento da view (se mduar de orentacao ou coisa assim a leyer n atualiza)
        
        view.layer.addSublayer(previewLayer) //adiciona a layer q criamos
        
        self.captureSession = session
        
        session.startRunning() //inicia a session
        
    }
}

extension CameraPreviewController: AVCapturePhotoCaptureDelegate {
    
    func takePhoto(){
        let settings = AVCapturePhotoSettings() //pega as configracoes de captura
        photoOutput.capturePhoto(with: settings, delegate: self) //usa o photoOutput pra tirar a foto
    }
    
    //funcao pra processar a foto
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        
        if let error = error {
            print("Houve um erro na captura da foto")
        }
        
        guard let photoData = photo.fileDataRepresentation(), let image = UIImage(data: photoData) else {return}
        
        delegate?.didCapturePhoto(image)
        
    }
}

//delegate da nossa função
protocol CameraPreviewControllerDelegate {
    func didCapturePhoto(_ image: UIImage)
}
