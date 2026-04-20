//
//  Level.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 08/04/2024.
//

import Foundation

struct Level: Codable {
    let level: Int
    let questions: [Question]
}
