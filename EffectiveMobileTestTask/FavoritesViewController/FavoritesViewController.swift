//
//  FavoritesViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var authenticationView: AuthenticationView!
    @IBOutlet weak var vacanciesView: ViewForFavoriteViewController!
    
    var dataManager : DataManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authenticationView.nextButtonClicked = { [weak self] in
            guard let self = self else { return }
            goToEmailConfirmation()
        }
        vacanciesView.data = dataManager.getFavoriteData()
        
        vacanciesView.updateSubviews = { [weak self] in
            guard let self = self else { return }
            self.viewDidLayoutSubviews()
        }
        
        vacanciesView.openVacancyDetail = { [weak self] id in
            guard let self = self else { return }
            openCell(id: id)
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
            vacanciesView.isHidden = false
        } else {
            vacanciesView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        vacanciesView.collectionViewHeightConstrain.constant = vacanciesView.collectionView.contentSize.height
    }

}

extension FavoritesViewController {
    private func openCell(id: UUID) {
        guard let navigationController = navigationController else { return }
        let data = dataManager.getDataFromJson(id: id)
        
        let viewController = VacancyViewController()
        viewController.id = id
        viewController.data = data
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}

extension FavoritesViewController : AuthenticationProtocol {
    func goToEmailConfirmation() {
        guard let navigationController = navigationController else { return }
        let viewController = CodeIntroductionElementsViewController()
        let email = authenticationView.loginView.emailTextField.text
        viewController.email = email
        navigationController.pushViewController(viewController, animated: true)
    }
}
