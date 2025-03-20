//
//  LanguageSetup.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 19/12/2023.
//

import UIKit

// This is our screen where users pick a language.
class LanguageSetup: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Here's our table that shows the language options.
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    // We've got a list of languages and their flags to show in the table.
    let languages = [("Spanish", "flag_of_Spain"), ("Italian", "flag_of_Italy")]
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // Adjust based on your cell content

        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        cell.selectionStyle = .none
        let (language, flag) = languages[indexPath.row]
        cell.titleLabel.text = language
        cell.imageCell.image = UIImage(named: flag)
        
        if indexPath == selectedIndexPath {
            cell.showSelectionBorder()
        } else {
            cell.hideSelectionBorder()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // Adjust this value as needed, including separator height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.showSelectionBorder()
        }
        
        continueButton.isEnabled = true
        continueButton.alpha = 1.0
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.hideSelectionBorder()
        }
        
        if tableView.indexPathForSelectedRow == nil {
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if let selectedIndexPath = selectedIndexPath {
                let selectedLanguage = languages[selectedIndexPath.row].0
                UserPreferences.selectedLanguage = selectedLanguage
                // Assuming you have a way to determine the current progress, for example:
                let currentProgress = ["Chapter 1", "Chapter 2"] // This should be dynamically determined
                UserPreferences.saveProgress(for: selectedLanguage, progress: currentProgress)
                // Continue with navigation
            }
        
        // Code to transition to the next screen would go here.
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
     

