//
//  LongQuestionViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 02/04/2024.
//

import UIKit

class LongQuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userXP = UserXP()
    var userScore = 0
    var userLives = 3
    var gainedUserXP = 0
    var isAnswerCorrect: Bool? = nil
    var questions: [Question] = []
    var currentQuestionIndex = 0
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UITextView!
    @IBOutlet weak var OptionsTableView: UITableView!
    @IBOutlet weak var IncorrectLabel: UILabel!
    
    @IBAction func continueButton(_ sender: Any) {
        guard let isCorrect = isAnswerCorrect else {
            print("Please select an option.")
            return
        }
        
        if isCorrect {
            userScore += 1
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                displayCurrentQuestion()
                resetQuestionState()
            } else {
                // Mark the lesson as completed
                unlockAchievement("Beginner's Luck")
                userXP.addXP(points: 5)
                gainedUserXP = 5
                performSegue(withIdentifier: "endQuizSegue", sender: self)
                
            }
        } else {
            userLives -= 1
            livesLabel.text = "\(userLives)"
            IncorrectLabel.text = "INCORRECT, TRY AGAIN"
            if userLives <= 0 {
                performSegue(withIdentifier: "outOfLivesSegue", sender: self)
            }
        }
    }
    
    // Inside LongQuestionViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        OptionsTableView.dataSource = self
        OptionsTableView.delegate = self
        displayCurrentQuestion()
        resetQuestionState()
        livesLabel.text = "\(userLives)"
        sentenceLabel.layer.cornerRadius = 10
    }

    func displayCurrentQuestion() {
        if questions.isEmpty || currentQuestionIndex >= questions.count { return }
        
        let currentQuestion = questions[currentQuestionIndex]
        sentenceLabel.text = currentQuestion.question
        shuffledOptions = currentQuestion.options.shuffled()
        OptionsTableView.reloadData()
    }
    
    var shuffledOptions: [String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! LongQuestionOptionsTableViewCell
        cell.optionLabel.text = shuffledOptions[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnswer = shuffledOptions[indexPath.row]
        isAnswerCorrect = selectedAnswer == questions[currentQuestionIndex].correctAnswer
        continueButton.isEnabled = true
    }

    func resetQuestionState() {
        isAnswerCorrect = nil
        continueButton.isEnabled = false
        continueButton.setTitleColor(.gray, for: .disabled)
        IncorrectLabel.text = ""
    }
    
    func unlockAchievement(_ title: String) {
        UserDefaults.standard.set(true, forKey: title)  // Unlocking the achievement
        // Optionally, send a notification or update UI if needed
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endQuizSegue",
           let destinationVC = segue.destination as? EndOfQuizViewController {
            destinationVC.score = userScore
            destinationVC.lives = userLives
            destinationVC.gainedXP = gainedUserXP
        }
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

