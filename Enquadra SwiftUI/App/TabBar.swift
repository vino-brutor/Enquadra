//
//  TabBar.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 06/08/25.
//

import SwiftUI

struct TabBar: View {
    
    @State var initialTab = 2 //state pra selecionar aba
    
    var body: some View {
        TabView(selection: $initialTab){
            
            NavigationStack{
                SubjectsView()
            }
            .tabItem {
                Text("Matérias")
                Image(systemName: "list.clipboard.fill")
            }.tag(1)
            
            NavigationStack{
                CameraView()
            }
            .tabItem {
                Text("Capturar")
                Image(systemName: "camera.fill")
            }.tag(2)
            
            NavigationStack{
                AccountView() //as telas tem um compoentne q é tabItem
            }
            .tabItem { //aqui dentro coloca o conteu da tab
                Text("Conta")
                Image(systemName: "person.2.fill")
            }
            .tag(3) //tag que representa cada uma das telas
            
        }
        
        
    }
}

#Preview {
    TabBar()
}
