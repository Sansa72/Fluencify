//
//  HomeScreenViewController.swift
//  Fluencify
//
//  Created by Iacopo Boaron on 07/01/2024.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var levelTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
     
    @IBAction func switchLanguage(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Switch Language", message: "Select a language", preferredStyle: .actionSheet)
        
        let languages = ["Spanish", "Italian"]
        for language in languages {
            alertController.addAction(UIAlertAction(title: language, style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                
                let currentLanguage = UserPreferences.selectedLanguage ?? "Spanish"
                let currentProgress = UserPreferences.retrieveProgress(for: currentLanguage) ?? ["Chapter 1"]
                
                UserPreferences.saveProgress(for: currentLanguage, progress: currentProgress)
                UserPreferences.selectedLanguage = language
                
                self.refreshAppForNewLanguage(language)
            }))
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIForSelectedLanguage()
        
        let language = UserPreferences.selectedLanguage ?? "Spanish"
        let progress = UserPreferences.retrieveProgress(for: language)

        // Do any additional setup after loading the view.
    }
    
    func updateUIForSelectedLanguage() {
            let language = UserPreferences.selectedLanguage ?? "Spanish"
            let progress = UserPreferences.retrieveProgress(for: language) ?? ["Chapter 1"]
            // Update the UI based on the progress for the selected language
        }
        
        func refreshAppForNewLanguage(_ language: String) {
            // Update UI elements if needed
            
            // Notify other parts of the app that need to refresh their content
            NotificationCenter.default.post(name: NSNotification.Name("LanguageDidChange"), object: nil)
            
            // Optionally, navigate to the main screen or refresh the current view
            self.navigationController?.popToRootViewController(animated: true)
            
            // Or, simply reload data in the current view if applicable
            updateUIForSelectedLanguage()
        }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
