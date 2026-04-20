//
//  UserPreferences.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 06/02/2024.
//

import Foundation

struct UserPreferences {
    // Existing methods
    static var selectedLanguage: String? {
        get { UserDefaults.standard.string(forKey: "selectedLanguage") }
        set { UserDefaults.standard.set(newValue, forKey: "selectedLanguage") }
    }

    // Save and retrieve user progress for a given language
    static func saveProgress(for language: String, progress: [String]) {
        UserDefaults.standard.set(progress, forKey: "progress_\(language)")
    }

    static func retrieveProgress(for language: String) -> [String]? {
        UserDefaults.standard.array(forKey: "progress_\(language)") as? [String]
    }
}
