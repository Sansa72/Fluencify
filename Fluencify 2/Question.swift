//
//  Question.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 08/04/2024.
//

import Foundation

struct Question: Codable {
    let question: String
    let options: [String]
    let correctAnswer: String
}
