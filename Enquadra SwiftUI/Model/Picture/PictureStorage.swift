//
//  PictureStorage.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import SwiftUI

enum PictureStorage {
    
    static func saveImage(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.9) else {return nil} //converte o UIImage em jpeg de compressao de 90%
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] //busca a url de documents do usuario (userdomainmask) e pega o primeiro
        
        let fileName = "\(UUID().uuidString).jpg" //cria um nome de arquivo unico
        
        let fileURL = directory.appendingPathComponent(fileName) //cria a url completa com appendingPathComponent
        
        do{
            try data.write(to: fileURL) //tenta escrever o arquiov no caminho do diretorio
            return fileName
        } catch {
            print("Problema ao tentar salvar o arquivo")
            return nil
        }
        
    }
    
    static func loadImage(fileName: String) -> UIImage? {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directory.appendingPathComponent(fileName)
        
        return UIImage(contentsOfFile: fileURL.path())
    }
    
    static func deleteImage(fileName: String) {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directory.appendingPathComponent(fileName)
        
        do{
            try FileManager.default.removeItem(at: fileURL)
        } catch{
            print("Erro ao deletar arquivo")
        }
    }
}
