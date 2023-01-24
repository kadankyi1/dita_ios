//
//  EBookModel.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI

// MARK: - DATA MODEL

struct EBookModel: Identifiable {
    var id = UUID()
    var book_id: Int
    var book_sys_id: String
    var book_title: String
    var book_author: String
    var book_ratings: Int
    var book_description_short: String
    var book_description_long: String
    var book_pages: Int
    var book_cover_photo: String
    var book_pdf: String
    var book_summary_pdf: String
    var book_audio: String
    var book_summary_audio: String
    var book_cost: String
    var book_summary_cost: String
    var book_full_purchased: String
    var book_summary_purchased: String
    var created_at: String
    var updated_at: String
}
