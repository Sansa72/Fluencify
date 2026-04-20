//
//  UserXP.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 16/04/2024.
//

import Foundation

struct UserXP {
    var XP: Int {
        didSet {
            saveToUserDefaults()
            NotificationCenter.default.post(name: NSNotification.Name("UserXPUpdated"), object: nil)
        }
    }
    var Rank: String {
        didSet {
            saveToUserDefaults()
            NotificationCenter.default.post(name: NSNotification.Name("UserXPUpdated"), object: nil)
        }
    }

    init() {
        XP = UserDefaults.standard.integer(forKey: "UserXP")
        Rank = UserDefaults.standard.string(forKey: "UserRank") ?? "Beginner"
    }

    func saveToUserDefaults() {
        UserDefaults.standard.set(XP, forKey: "UserXP")
        UserDefaults.standard.set(Rank, forKey: "UserRank")
    }

    mutating func addXP(points: Int) {
        XP += points
        updateRank()
    }

    private mutating func updateRank() {
        switch XP {
        case 0..<100:
            Rank = "Beginner"
        case 100..<500:
            Rank = "Intermediate"
        case 500..<1000:
            Rank = "Advanced"
        default:
            Rank = "Expert"
        }
    }
}
