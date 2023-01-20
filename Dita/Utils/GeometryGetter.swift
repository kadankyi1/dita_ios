//
//  GeometryGetter.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI
import Foundation

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}
