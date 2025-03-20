//
//  LearnViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 07/01/2024.
//

import UIKit

class LearnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var chapters: [Chapter] = []
    
    @IBOutlet weak var ChaptersTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChaptersTableViewCell", for: indexPath) as! ChaptersTableViewCell
            let chapter = chapters[indexPath.row]
            cell.chaptersLabel.text = chapter.title // Ensure the IBOutlet name matches here
            return cell
    }

    @objc func updateContent() {
           // Reload the chapters based on the new language
           loadChaptersForCurrentLanguage()
       }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           NotificationCenter.default.addObserver(self, selector: #selector(updateContent), name: NSNotification.Name("LanguageDidChange"), object: nil)
           
           // Additional setup
           ChaptersTableView.dataSource = self
           ChaptersTableView.delegate = self
           
           // Load chapters
           updateContent()
       }
    
    @objc func languageDidChange() {
        // Reload the chapters based on the new language
        loadChaptersForCurrentLanguage()
    }

    func loadChaptersForCurrentLanguage() {
            let languageFileName = UserPreferences.selectedLanguage == "Spanish" ? "SpanishChapters" : "ItalianChapters"
            chapters = parseChapters(fromTextFileNamed: languageFileName)
            DispatchQueue.main.async {
                self.ChaptersTableView.reloadData()
            }
        }
    
    func parseChapters(fromTextFileNamed fileName: String) -> [Chapter] {
        // Assuming the file is in the main bundle for simplicity
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt"),
              let fileContents = try? String(contentsOfFile: filePath)
        else {
            print("Failed to read the file")
            return []
        }
        
        var chapters = [Chapter]()
        // Splitting the entire content by "/" to separate chapters
        let chaptersData = fileContents.components(separatedBy: "/\n\n")
        
        for chapterData in chaptersData where !chapterData.isEmpty {
            // Finding the range of ":" to identify the start of the content
            if let range = chapterData.range(of: ":\n\n") {
                let title = String(chapterData[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
                let contentString = String(chapterData[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
                let contentsLines = contentString.split(separator: "\n").map(String.init)
                
                var content = [String: String]()
                for line in contentsLines {
                    let parts = line.components(separatedBy: " - ")
                    if parts.count == 2 {
                        content[parts[0]] = parts[1]
                    }
                }
                
                if !title.isEmpty && !content.isEmpty {
                    chapters.append(Chapter(title: title, content: content))
                }
            }
        }
        
        return chapters
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "ShowChapterContent", sender: indexPath)
    }
    
    var currentIndex = -1
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChapterContent"{ //,
            
            let destinationVC = segue.destination as? ChaptContentViewController //,
                //let indexPath = sender as? IndexPath {
            let selectedChapter = chapters[currentIndex]
            // Convert the chapter content dictionary to an array of tuples
            destinationVC!.chapterContent = Array(selectedChapter.content.map { ($0, $1) })
           //}
            
        }
            
        
    }


}
