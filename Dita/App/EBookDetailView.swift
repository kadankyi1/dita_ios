//
//  EBookDetailView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI
import URLImage // Import the package module

struct EBookDetailView: View {
    // MARK: -- PROPERTIES
    var ebook: EBookModel
    @State private var isAnimatingImage: Bool = false
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                if #available(iOS 14.0, *) {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                        // HEADER
                        ZStack {
                            let this_url = URL(string: ebook.book_cover_photo);
                            URLImage(this_url!,
                                     content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .shadow(radius: 4)
                                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 250, idealHeight: 300, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                     })
                        }
                        .frame(height: 300)
                        .onAppear(){
                            withAnimation(.easeOut(duration: 0.5)){
                                isAnimatingImage = true
                            }
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 20){
                            // TITLE
                            Text(ebook.book_title)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("ColorDarkBlueAndDarkBlue"))
                                .lineLimit(2)
                                .padding(.top, 50)
                            
                            // DATE
                            Text(ebook.book_author)
                                .font(.footnote)
                            
                            // DESCRIPTION
                            Text(ebook.book_description_long)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            
                        } //: VSTACK
                        .padding(.horizontal, 20)
                        .frame(maxWidth: 640, alignment: .center)
                    } //: VSTACK
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                } else {
                    // Fallback on earlier versions
                }
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
    }
}


// MARK -- PREVIEW
struct EBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EBookDetailView(ebook: EBooksData[0])
    }
}
