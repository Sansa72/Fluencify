//
//  ChooseDifficulty.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 28/12/2023.
//

import UIKit

class ChooseDifficulty: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var continueButtonPressed: UIButton!
    
    let difficulties = [("No Clue", ""), ("Somewhat Experienced", ""), ("Experienced", "")]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.isScrollEnabled = false
        
        continueButtonPressed.isEnabled = false  // Disable the continue button initially
        continueButtonPressed.alpha = 0.5        // Make the button look disabled
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return difficulties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        cell.selectionStyle = .none
        let (difficulty, flag) = difficulties[indexPath.row]
        cell.titleLabel.text = difficulty
        cell.imageCell.image = UIImage(named: flag)
        
        // Show or hide the custom selection border view
        cell.setSelected(indexPath == selectedIndexPath, animated: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath, previousIndexPath != indexPath {
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? TableViewCell {
                previousCell.setSelected(false, animated: true)
            }
        }

        selectedIndexPath = indexPath
        if let selectedCell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            selectedCell.setSelected(true, animated: true)
        }
        
        continueButtonPressed.isEnabled = true  // Enable the continue button
        continueButtonPressed.alpha = 1.0       // Make the button look enabled
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.setSelected(false, animated: true)
        }
        
        if tableView.indexPathForSelectedRow == nil {
            continueButtonPressed.isEnabled = false  // Disable the button if no cell is selected
            continueButtonPressed.alpha = 0.5        // Make the button look disabled
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        // Perform the necessary action when the continue button is pressed
        // This may involve navigating to a new view controller or performing a segue
        
        if let selectedIndexPath = selectedIndexPath {
            let selectedDifficulty = difficulties[selectedIndexPath.row].0
            UserDefaults.standard.set(selectedDifficulty, forKey: "selectedDifficulty")
            tableView.deselectRow(at: selectedIndexPath, animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController") as! UITabBarController
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
            if let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? TableViewCell {
                selectedCell.setSelected(false, animated: true)
            }
            self.selectedIndexPath = nil
            
            continueButtonPressed.isEnabled = false  // Disable the continue button after press
            continueButtonPressed.alpha = 0.5        // Make the button look disabled
        }
    }


}
