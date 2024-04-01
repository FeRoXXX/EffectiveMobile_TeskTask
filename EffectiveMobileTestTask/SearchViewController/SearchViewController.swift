//
//  SearchViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var authenticationView: AuthenticationView!
    @IBOutlet weak var mainView: ViewForSearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationView.nextButtonClicked = { [weak self] in
            guard let self = self else { return }
            goToEmailConfirmation()
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !authenticationView.isHidden {
            authenticationView.loginView.emailTextField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults().bool(forKey: "isUserLoggedIn") {
            authenticationView.isHidden = true
            let dataArray = JsonRequestData.getDataFromJson()
            mainView.dataArray = dataArray
        }
    }
    
    override func viewDidLayoutSubviews() {
        mainView.collectionViewHeightConstraint.constant = mainView.vacancyCollectionView.contentSize.height
    }

}

extension SearchViewController: AuthenticationProtocol {
    func goToEmailConfirmation() {
        guard let navigationController = navigationController else { return }
        let viewController = CodeIntroductionElementsViewController()
        let email = authenticationView.loginView.emailTextField.text
        viewController.email = email
        navigationController.pushViewController(viewController, animated: true)
    }
}
