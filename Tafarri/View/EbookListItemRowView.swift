//
//  EbookListItemRowView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI
import URLImage // Import the package module

struct EbookListItemRowView: View {
    // MARK: - PROPERTIES
    var ebook: EBookModel
    
    // MARK: - BODY
    var body: some View {
        GroupBox(){
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(ebook.book_title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text(ebook.book_description_short.prefix(100) + "...")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                    Text("  " + ebook.book_author + "  ")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color.white)
                        .background(Color("ColorGrayTwo"))
                        .cornerRadius(2)
                }
                let this_url = URL(string: ebook.book_cover_photo);
                URLImage(this_url!,
                         content: { image in
                             image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                         })
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
    }
}

// MARK: - PREVIEW
struct EbookListItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        EbookListItemRowView(ebook: EBooksData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
