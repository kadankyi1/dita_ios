//
//  StartButtonView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @Binding var currentStage: String
    @AppStorage("appStage") var appStage: String?
    
    
    // MARK: - BODY
    var body: some View {
        
        Button(action: {
            //appStage = "LoginView"
            self.currentStage = "GetLoginCodeView"
        }) {
            HStack (spacing: 8) {
                Text("START")
                    .foregroundColor(Color("ColorDarkBlueAndDarkBlue"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundColor(Color("ColorWhite"))
        } //: BUTTON
        .accentColor(Color("ColorWhite"))
        .background(Color("ColorWhite"))
        .cornerRadius(20)
        
        
    }
}

    // MARK - PREVIEW


struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(currentStage: .constant("LoginView"))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
 
