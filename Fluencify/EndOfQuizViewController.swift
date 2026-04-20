//
//  EndOfQuizViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 08/04/2024.
//

import UIKit

class EndOfQuizViewController: UIViewController {

    var gainedXP = 0
    var score = 0
    var lives = 0
    
    
    @IBOutlet weak var livesLost: UILabel!
    @IBOutlet weak var gainedXPLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        livesLost.text = "Lives Lost: \(3 - lives)"
        gainedXPLabel.text = "Gained XP: \(gainedXP)"
        
        
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
