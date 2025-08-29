//
//  SendPicutreView.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 27/08/25.
//

import SwiftUI

struct SendPicutreView: View {
    
    var picture: Picture
    
    var body: some View {
        
    ZStack(alignment: .bottom) {
            if let picture = PictureStorage.loadImage(fileName: picture.picturePath) {
                
                Image(uiImage: picture)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(maxWidth: .infinity, minHeight: 665)
                    .ignoresSafeArea(.container)
                    
            }
            
            HStack {
                Button {
                    
                } label: {
                    
                    ZStack(alignment: .center){
                        Circle()
                            .fill(.ceuLimpo)
                            .frame(width: 80, height: 80)
                        
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size: 30).weight(.medium))
                                .padding(.bottom, 5)
                        }
                        .foregroundStyle(.grafite)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, minHeight: 104)
            .background(.grafite)
        }
    }
}

//#Preview {
//    SendPicutreView()
//}
