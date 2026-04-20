//
//  BossEndViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 11/04/2024.
//

import UIKit

class BossEndViewController: UIViewController {
    
    var gainedLives  = 0
    var livesLost = 0
    var gainedXP = 0
    
    @IBOutlet weak var LivesLost: UILabel!
    @IBOutlet weak var gainedXPLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LivesLost.text = "Lives Lost \(livesLost)"
        gainedXPLabel.text = "Gained XP: \(gainedXP)"
        // Do any additional setup after loading the view.
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
