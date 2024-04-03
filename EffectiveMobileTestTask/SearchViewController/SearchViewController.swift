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
    
    var dataManager : DataManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.dataArray = dataManager.getDataFromJson()
        mainView.favoritesData = dataManager.getIdsFromCoreData()
        authenticationView.nextButtonClicked = { [weak self] in
            guard let self = self else { return }
            goToEmailConfirmation()
        }
        mainView.openVacancy = { [weak self] id in
            guard let self = self else { return }
            openCell(id: id)
        }
        
        mainView.updateSubviews = { [weak self] in
            guard let self = self else { return }
            self.viewDidLayoutSubviews()
        }
        
        mainView.deleteLike = { [weak self] id, cell in
            guard let self = self else { return }
            dataManager.deleteIdFromCoreData(id: id)
            mainView.favoritesData = dataManager.getIdsFromCoreData()
            mainView.vacancyCollectionView.reloadData()
            viewDidLayoutSubviews()
        }
        
        mainView.setLike = { [weak self] id, cell in
            guard let self = self else { return }
            dataManager.saveDataToCoreData(id: id)
            mainView.favoritesData = dataManager.getIdsFromCoreData()
            mainView.vacancyCollectionView.reloadData()
            viewDidLayoutSubviews()
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
            mainView.isHidden = false
            mainView.dataArray = dataManager.getDataFromJson()
            mainView.favoritesData = dataManager.getIdsFromCoreData()
            mainView.vacancyCollectionView.reloadData()
        } else {
            dataManager.copyFavoriteDataToCoreData()
            mainView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        mainView.collectionViewHeightConstraint.constant = mainView.vacancyCollectionView.contentSize.height
    }

}

extension SearchViewController {
    private func openCell(id: UUID) {
        guard let navigationController = navigationController else { return }
        let data = dataManager.getDataFromJson(id: id)
        var idArray = dataManager.getIdsFromCoreData()
        let viewController = VacancyViewController()
        if let idArray = idArray {
            if idArray.contains(where:  { $0.id == id } ) {
                viewController.isFavorite = true
            } else {
                viewController.isFavorite = false
            }
        }
        viewController.id = id
        viewController.data = data
        navigationController.pushViewController(viewController, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
        viewController.setLikeButton = { [weak self] id in
            guard let self = self else { return }
            if let idArray = idArray {
                if idArray.contains(where:  { $0.id == id } ) {
                    dataManager.deleteIdFromCoreData(id: id)
                    viewController.isFavorite = false
                } else {
                    dataManager.saveDataToCoreData(id: id)
                    viewController.isFavorite = true
                }
            }
            idArray = dataManager.getIdsFromCoreData()
        }
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
