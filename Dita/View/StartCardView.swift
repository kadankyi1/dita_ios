//
//  StartCardView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI

struct StartCardView: View {
    // MARK: - PROPERTIES
    
    var start: StarterModel
    @State private var isAnimating: Bool = false
    @Binding var currentStage: String
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack (spacing: -70) {
                // FRUIT IMAGE
                Image(start.image)
                    .resizable()
                    .scaleEffect(x: 0.4, y: 0.4, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    //.scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
            
                // FRUIT TITLE
                Text("Dita: Learning Aid")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                Text("'One hour per day of study in your chosen field is all it takes. One hour per day of study will put you at the top of your field within three years. Within five years you’ll be a national authority. In seven years, you can be one of the best people in the world at what you do.” — Earl Nightingale'")
                    .foregroundColor(Color.white)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 70)
                    .frame(maxWidth: 480)
                
                // FRUIT HEADLINE
            
                // BUTTON: START
                StartButtonView(currentStage: $currentStage)
                    .padding(.vertical, 35)
            } //: VSTACK
        } //: ZSTACK
        .onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                isAnimating = true
            }
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorDarkBlueAndDarkBlue")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        //.cornerRadius(20)
        //.padding(.horizontal, 10)
    }
}

// MARK: - PREVIEW
struct StartCardView_Previews: PreviewProvider {
    static var previews: some View {
        StartCardView(start: startData[0], currentStage: .constant("SignupView"))
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
 
