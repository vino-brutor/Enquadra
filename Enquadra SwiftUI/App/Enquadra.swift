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
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }.modelContainer(for: Subject.self)
    }
}
