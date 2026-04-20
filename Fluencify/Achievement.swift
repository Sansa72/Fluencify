//
//  Achievement.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 14/04/2024.
//

import Foundation

struct Achievement {
    let title: String
    let description: String
    var achieved: Bool {
        get { UserDefaults.standard.bool(forKey: title) }
        set { UserDefaults.standard.set(newValue, forKey: title) }
    }
}
