//
//  ProfileViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var authenticationView: AuthenticationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        authenticationView.nextButtonClicked = { [weak self] in
            guard let self = self else { return }
            goToEmailConfirmation()
        }
    }

}

extension ProfileViewController: AuthenticationProtocol {
    func goToEmailConfirmation() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(CodeIntroductionElementsViewController(), animated: true)
    }
}
