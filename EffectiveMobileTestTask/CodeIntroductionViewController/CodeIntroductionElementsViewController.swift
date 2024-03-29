//
//  EmailConfirmationViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class CodeIntroductionElementsViewController: UIViewController {
    @IBOutlet weak var customView: CodeIntroductionElements!
    
    var email : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.sendToEmailLabel.text = "Отправили код на " + email
        
        customView.toMainMenu = { [weak self] in
            guard let self = self else { return }
            toMainMenu()
        }
    }

    private func toMainMenu() {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        navigationController?.popToRootViewController(animated: true)
    }
    
}
