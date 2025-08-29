//
//  CircleButton.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 11/08/25.
//

import SwiftUI

struct CircleButton: View {
    
    var textButton: String?
    var isImage:Bool
    @State var isActive: Bool = false
    var buttonAction: () -> Void
    
    var body: some View {
        Button{
            buttonAction()
            isActive.toggle()
        } label: {
            
            ZStack{
                
                Circle()
                    .frame(width: 53.33, height: 53.33)
                    .foregroundStyle(isActive ? .sol : .grafite)
                
                if let textButton = textButton{
                    if isImage {
                        Image(systemName: textButton)
                            .foregroundStyle(isActive ? .grafite : .sol)
                            .font(.system(size: 24).weight(.medium))
                    } else {
                        Text(textButton)
                            .foregroundStyle(isActive ? .grafite : .areia)
                            .font(.system(size: 24).weight(.medium))
                    }
                }
                
            }
        }
    }
}

#Preview {
    
}
