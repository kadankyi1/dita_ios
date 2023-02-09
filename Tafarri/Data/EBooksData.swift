//
//  EBooksData.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI

// MARK: - START DATA

let EBooksData: [EBookModel] = [
    EBookModel(
        book_id: 1,
        book_sys_id: "book_sys_id_1",
        book_title: "Book 1",
        book_author: "Author One",
        book_ratings: 1,
        book_description_short: "1 This is a short description",
        book_description_long: "1 This is a long description. This is a long description. This is a long description. This is a long description. This is a long description. ",
        book_pages: 100,
        book_cover_photo: "book_cover_photo_1",
        book_pdf: "book_pdf_1",
        book_summary_pdf: "book_summary_pdf_1",
        book_audio: "book_audio_1",
        book_summary_audio: "book_summary_audio_1",
        book_cost: "$2",
        book_summary_cost: "$3",
        book_full_purchased: "no",
        book_summary_purchased: "no",
        created_at: "Dec 12, 2022",
        updated_at: "Dec 12, 2022"
    ),
        EBookModel(
            book_id: 2,
            book_sys_id: "book_sys_id_2",
            book_title: "Book 2",
            book_author: "Author Two",
            book_ratings: 2,
            book_description_short: "2 This is a short description",
            book_description_long: "2 This is a long description. This is a long description. This is a long description. This is a long description. This is a long description. ",
            book_pages: 200,
            book_cover_photo: "book_cover_photo_2",
            book_pdf: "book_pdf_2",
            book_summary_pdf: "book_summary_pdf_2",
            book_audio: "book_audio_2",
            book_summary_audio: "book_summary_audio_2",
            book_cost: "$4",
            book_summary_cost: "$5",
            book_full_purchased: "no",
            book_summary_purchased: "no",
            created_at: "Dec 13, 2022",
            updated_at: "Dec 13, 2022"
        )
]
