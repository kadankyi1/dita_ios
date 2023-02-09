//
//  SummaryDetailView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI
import URLImage // Import the package module

struct SummaryDetailView: View {
    // MARK: -- PROPERTIES
    var ebook: EBookModel
    @State private var isAnimatingImage: Bool = false
    
    // MARK: -- BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                        // HEADER
                        VStack {
                            let this_url = URL(string: ebook.book_cover_photo);
                            URLImage(this_url!,
                                     content: { image in
                                         image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 320, height: 320, alignment: .center)
                                            .clipped()
                                            .cornerRadius(8)
                                     })
                        }
                        .frame(height: 300)
                        .padding(.top, 20)
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
                            HStack{
                                Text("By: " + ebook.book_author)
                                    .font(.footnote)
                                Spacer()
                                
                                VStack(){
                                    Text(ebook.book_cost)
                                        .font(.title)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("ColorAccentOppBlack"))
                                        .lineLimit(2)
                                    Text("Summary")
                                        .font(.system(size: 10))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color("ColorAccentOppBlack"))
                                        .lineLimit(2)
                                }
                            }
                            
                            
                            Text("REFERENCE : " + ebook.book_sys_id)
                                .font(.headline)
                                .fontWeight(.bold)
                        
                            EBookDetailsActionButtonView(purchased: ebook.book_full_purchased, ebook_name: ebook.book_title, ebook_pdf_url: ebook.book_pdf, ebook_ref: ebook.book_sys_id, read_text: "READ FULL BOOK")
                            
                        
                            EBookDetailsActionButtonView(purchased: ebook.book_summary_purchased, ebook_name: ebook.book_title, ebook_pdf_url: ebook.book_summary_pdf, ebook_ref: ebook.book_sys_id, read_text: "READ SUMMARY")
                            
                            // DESCRIPTION
                            Text(ebook.book_description_long)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            
                        } //: VSTACK
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    } //: VSTACK
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// MARK -- PREVIEW
struct SummaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryDetailView(ebook: EBooksData[0])
    }
}
