//
//  HomeScreenViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 07/01/2024.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var levelTableView: UITableView!
    // Inside HomeScreenViewController

    var chapters: [Chapter] = []
    var avLanguage = ""

    override func viewDidLoad() {
        levelTableView.dataSource = self
        levelTableView.delegate = self
        super.viewDidLoad()
        chapters = Chapter.chapters(fromTextFileNamed: "SpanishChapters") // Initial load
        levelTableView.dataSource = self
        updateUIForSelectedLanguage()
        
        // Listen for language change notifications
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIForSelectedLanguage), name: Notification.Name("LanguageDidChangeNotification"), object: nil)
    }
    
    // DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return chapters.count - 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return chapters[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ensure to cast the dequeued cell to LevelsTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as? LevelsTableViewCell
        // Extracting the chapter content
        //let chapterContent = Array(chapters[indexPath.section].content.values)
        //let startIndex = indexPath.row * 5
        //let endIndex = min(startIndex + 4, chapterContent.count - 1)
        //let levelContent = chapterContent[startIndex...endIndex].joined(separator: ", ")
        
        // Set the text of the levelsLabel to show the levels information
        
        if(indexPath.row < 5){
            cell!.levelsLabel.text = "Level \(indexPath.row + 1)"
        }
        else{
            cell!.levelsLabel.text = "\u{1F480} BOSS FIGHT \u{1F480}"
        }
        
        return cell!
    }


    func loadChapterLevels(for language: String, chapterNumber: Int) -> ChapterLevels? {
        // Construct the file name according to the given pattern.
        let fileName = "\(language.lowercased())Chapter\(chapterNumber)"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load or find \(fileName).json")
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let chapterLevels = try decoder.decode(ChapterLevels.self, from: data)
            return chapterLevels
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }

    
    @IBAction func switchLanguage(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Switch Language", message: "Select a language", preferredStyle: .actionSheet)
        // Example languages
        let languages = ["Spanish", "Italian"]
        
        for language in languages {
            alertController.addAction(UIAlertAction(title: language, style: .default, handler: { _ in
                // Save current progress for the old language
                let currentLanguage = UserPreferences.selectedLanguage ?? "Spanish"
                let currentProgress = ["Chapter 1", "Chapter 2"] // This should be dynamically determined
                UserPreferences.saveProgress(for: currentLanguage, progress: currentProgress)
                        
                // Switch to the new language
                UserPreferences.selectedLanguage = language
                        
                // Load progress for the new language
                let newLanguageProgress = UserPreferences.retrieveProgress(for: language)
                
                // Refresh the app content according to the new language selection
                UserPreferences.selectedLanguage = language

                // Post a notification to inform the app about the language change
                NotificationCenter.default.post(name: Notification.Name("LanguageDidChangeNotification"), object: nil)
            }))
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
        
    }
    
    @objc func updateUIForSelectedLanguage() {
        // This method will update the UI for the selected language
        if let language = UserPreferences.selectedLanguage, language == "Italian" {
            chapters = Chapter.chapters(fromTextFileNamed: "ItalianChapters")
            avLanguage = "it-IT"
        } else {
            chapters = Chapter.chapters(fromTextFileNamed: "SpanishChapters")
            avLanguage = "es-ES"
        }
        levelTableView.reloadData()
    }
    
    func refreshAppForNewLanguage(_ language: String) {
     
        // Notify other parts of the app that need to refresh their content
        NotificationCenter.default.post(name: NSNotification.Name("LanguageDidChange"), object: nil)
        
        // Optionally, navigate to the main screen or refresh the current view
        self.navigationController?.popToRootViewController(animated: true)
        

        // Or, simply reload data in the current view if applicable
        updateUIForSelectedLanguage()
    }

    var selectedChapterIndex = -1
    var selectedLevelIndex = -1

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Perform the segue
        selectedChapterIndex = indexPath.section // Capture the selected chapter index
        selectedLevelIndex = indexPath.row // Capture the selected level index
        
        if indexPath.row < 5 {
            performSegue(withIdentifier: "showQuizSegue", sender: self)
        }
        else{
            performSegue(withIdentifier: "toBossLevelSegue", sender: self)
        }
        
        levelTableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Inside HomeScreenViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showQuizSegue", let destinationVC = segue.destination as? LongQuestionViewController {
            let language = UserPreferences.selectedLanguage ?? "Spanish" // Default language
            if let chapterLevels = loadChapterLevels(for: language, chapterNumber: selectedChapterIndex + 1) { // Chapters are 1-indexed
                let selectedLevelQuestions = chapterLevels.levels[selectedLevelIndex].questions
                destinationVC.questions = selectedLevelQuestions
            }
        }
        
        else if segue.identifier == "toBossLevelSegue", let destinationVC = segue.destination as? BossViewController{
            let language = UserPreferences.selectedLanguage ?? "Spanish" // Default language
            if let chapterLevels = loadChapterLevels(for: language, chapterNumber: selectedChapterIndex + 1) {// Chapters are 1-indexed
                let selectedLevelQuestions = chapterLevels.levels[selectedLevelIndex].questions
                destinationVC.questions = selectedLevelQuestions
                destinationVC.avUserLanguage = avLanguage
                //print(selectedLevelQuestions)
            }
        }
        
    }

    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){
    }
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }

}
