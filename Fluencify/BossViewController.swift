//
//  BossViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 10/04/2024.
//

import UIKit
import AVFoundation

class BossViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVSpeechSynthesizerDelegate {
    
    var userXP = UserXP()
    var userGainedXP = 0
    var speechSynthesizer = AVSpeechSynthesizer()
    var avUserLanguage: String = ""
    var userScore = 0
    var userLostLives = 0
    var userLives = 3
    var isAnswerCorrect: Bool? = nil
    var questions: [Question] = []
    var currentQuestionIndex = 0
    
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var QuestionTextView: UITextView!
    @IBOutlet weak var LivesLabel: UILabel!
    @IBOutlet weak var OptionsTableView: UITableView!
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        guard let isCorrect = isAnswerCorrect else {
            // Optional: Alert the user to select an option if none is selected
            print("Please select an option.")
            return
        }
        
        if isCorrect {
            userScore += 1
            
            if Int.random(in: 1...100) <= 40{
                
                userLives += 1
                LivesLabel.text = "\(userLives)"
                
                unlockAchievement("1UP")
                
            }
            else if Int.random(in: 1...100) <= 20{
                
                userLives += 2
                LivesLabel.text = "\(userLives)"
                
                unlockAchievement("1UP")
                
            }
            else if Int.random(in: 1...100) <= 10{
                
                userLives += 3
                LivesLabel.text = "\(userLives)"
                
                unlockAchievement("1UP")
                
            }
            
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                isAnswerCorrect = nil // Reset the flag
                displayCurrentQuestion()
                isAnswerCorrect = nil
                ContinueButton.isEnabled = false
                ContinueButton.setTitleColor(.gray, for: .disabled)
                //IncorrectLabel.text = ""
            } else {
                
                unlockAchievement("Fatality")
                userXP.addXP(points: 20)
                userGainedXP = 20
                
                performSegue(withIdentifier: "endQuizSegue", sender: self)
            }
        } else {
            userLives -= 1
            userLostLives += 1
            
            if avUserLanguage == "it-IT"{
                
                let speechUtterance = AVSpeechUtterance(string: "Non capisco, puoi ripetere. per favore")
                speechUtterance.voice = AVSpeechSynthesisVoice(language: avUserLanguage)
                speechSynthesizer.speak(speechUtterance)
                
            }
            
            else if avUserLanguage == "es-ES"{
                
                let speechUtterance = AVSpeechUtterance(string: "No entiendo, puede repetir. por favor")
                speechUtterance.voice = AVSpeechSynthesisVoice(language: avUserLanguage)
                speechSynthesizer.speak(speechUtterance)
                
            }
            
            
            isAnswerCorrect = nil // Reset the flag
            LivesLabel.text = "\(userLives)"
            //IncorrectLabel.text = "INCORRECT, TRY AGAIN"
            if userLives <= 0 {
                // Handle the case when the user runs out of lives, e.g., show an alert or end the quiz
                performSegue(withIdentifier: "outOfLivesSegue", sender: self)
            }
            // If the answer is wrong, just update lives and wait for the correct answer without moving to the next question
        }
        
        
    }

    func unlockAchievement(_ title: String) {
        UserDefaults.standard.set(true, forKey: title)  // Unlocking the achievement
        // Optionally, send a notification or update UI if needed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(questions)
        print(currentQuestionIndex)
        
        super.viewDidLoad()
        
        OptionsTableView.dataSource = self
        OptionsTableView.delegate = self
        
        displayCurrentQuestion()
        LivesLabel.text = "\(userLives)"
        
        ContinueButton.isEnabled = false
        ContinueButton.setTitleColor(.gray, for: .disabled)
        
        //IncorrectLabel.text = ""
        
    }
    
    var shuffledOptions: [String] = []
    
    func displayCurrentQuestion() {
        if questions.isEmpty || currentQuestionIndex >= questions.count { return }
        
        let currentQuestion = questions[currentQuestionIndex]
        QuestionTextView.text = currentQuestion.question
        
        // Shuffle the options for the current question and store them
        shuffledOptions = currentQuestion.options.shuffled()
        
        OptionsTableView.reloadData()
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! BossOptionsTableViewCell
        cell.OptionLabel.text = shuffledOptions[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnswer = shuffledOptions[indexPath.row]
        isAnswerCorrect = selectedAnswer == questions[currentQuestionIndex].correctAnswer
        
        let speechUtterance = AVSpeechUtterance(string: selectedAnswer)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: avUserLanguage)
        speechSynthesizer.speak(speechUtterance)
        
        ContinueButton.isEnabled = true
    }

    
    @IBAction func SpeakButton(_ sender: Any) {
        
        let currentQuestion = questions[currentQuestionIndex]
        
        let speechUtterance = AVSpeechUtterance(string: currentQuestion.question)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: avUserLanguage)
        speechSynthesizer.speak(speechUtterance)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "endQuizSegue"{
            
            let destinationVC = segue.destination as? BossEndViewController
            
            destinationVC!.livesLost = userLostLives
            destinationVC!.gainedXP = userGainedXP
            
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
