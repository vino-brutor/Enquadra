//
//  Extensions.swift
//  Enquadra SwiftUI
//
//  Created by Vítor Bruno on 08/08/25.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}
