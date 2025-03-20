//
//  ChaptContentViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 23/02/2024.
//

import UIKit
import AVFoundation

class ChaptContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVSpeechSynthesizerDelegate {
    
    var chapterContent: [(String, String)] = []
    let speechSynthesizer = AVSpeechSynthesizer()
    let voices = AVSpeechSynthesisVoice.speechVoices()
    
    @IBOutlet weak var contentTableView: UITableView!

       override func viewDidLoad() {
           super.viewDidLoad()
           contentTableView.dataSource = self
           contentTableView.delegate = self
           
           //contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "WordCell")
           
           print("hello")
           
           print(chapterContent)
           
           
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print(chapterContent.count)
           return chapterContent.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as? ChaptCTableViewCell
           let wordPair = chapterContent[indexPath.row]
           cell!.labelContent.text = "\(wordPair.0)"
           cell!.labelContent2.text = "\(wordPair.1)"
           print(cell)
           return cell!
       }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Deselect the row to remove the highlight
            tableView.deselectRow(at: indexPath, animated: true)

            // Get the text from the cell that was tapped
            let wordPair = chapterContent[indexPath.row]
            let textToSpeak = "\(wordPair.0)"

            // Use AVSpeechSynthesizer to speak the text
            let speechUtterance = AVSpeechUtterance(string: textToSpeak)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
            
            
            speechSynthesizer.speak(speechUtterance)
            
            if let voice = AVSpeechSynthesisVoice(language: "es-ES") {
                speechUtterance.voice = voice
            } else {
                print("Requested voice not available.")
            }
            
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
