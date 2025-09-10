//
//  Enquadra_SwiftUIApp.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 06/08/25.
//

import SwiftUI

@main
struct Enquadra: App {
    
    //Usando UIKit no swiftUI
    init(){
        UITabBar.appearance().backgroundColor = .gelo
        UITabBar.appearance().unselectedItemTintColor = .grafite
        
        let appearance = UINavigationBarAppearance()
        
        // Define a cor do título para títulos pequenos na barra
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.grafite),
        ]
        
        // Define a cor do título para títulos grandes (quando a barra expande)
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.grafite)
        ]
        
        // Aplica a aparência para os estados normal e de rolagem da barra
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }.modelContainer(for: [
            Subject.self,
        ])
    }
}
