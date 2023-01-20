//
//  MainView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI

struct MainView: View {
    @Binding var currentStage: String
    
    init(currentStage: Binding<String>) {
        self._currentStage = .constant("MainView")
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentStage: .constant("MainView"))
    }
}
