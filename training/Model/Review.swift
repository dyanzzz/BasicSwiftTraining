//
//  Review.swift
//  training
//

import Foundation

struct Review: Identifiable {
    let id = UUID()
    let author: String
    let rating: Int
    let date: String
    let comment: String
    let helpfulCount: Int
}
