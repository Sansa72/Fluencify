//
//  TrophiesViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 07/01/2024.
//

import UIKit

class TrophiesViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var achievementsTableView: UITableView!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var achievements: [Achievement] = [
        Achievement(title: "Beginner's Luck", description: "Complete your first lesson"),
        Achievement(title: "You're on a roll", description: "Complete the first chapter"),
        Achievement(title: "Polyglot", description: "Learn more than 1 language"),
        Achievement(title: "Fatality", description: "Complete your first boss"),
        Achievement(title: "Quiz Master", description: "Complete all chapters"),
        Achievement(title: "1UP", description: "Gain at least one extra life in a boss level")
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        achievementsTableView.dataSource = self
        achievementsTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name("UserXPUpdated"), object: nil)
        
        updateUI()
        
        xpLabel.layer.cornerRadius = 8
        rankLabel.layer.cornerRadius = 8

        xpLabel.clipsToBounds = true
        rankLabel.clipsToBounds = true

        xpLabel.layer.borderWidth = 2
        rankLabel.layer.borderWidth = 2

    }
    
    @objc func updateUI() {
        xpLabel.text = "XP: \(UserXP().XP)"
        rankLabel.text = "RANK: \(UserXP().Rank)"
    }

    deinit {
            NotificationCenter.default.removeObserver(self)
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        achievementsTableView.reloadData()  // Refresh to display the latest statuses
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell", for: indexPath) as! AchievementTableViewCell
        let achievement = achievements[indexPath.row]
        cell.titleLabel.text = achievement.title
        cell.descriptionLabel.text = achievement.description
        cell.accessoryType = achievement.achieved ? .checkmark : .none
        return cell
    }


}
