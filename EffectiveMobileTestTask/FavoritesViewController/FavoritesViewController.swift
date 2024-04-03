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
        vacanciesView.favoritesData = dataManager.getIdsFromCoreData()
        if let favorite = dataManager.getIdsFromCoreData() {
            vacanciesView.dataArray = dataManager.getFavoriteDataFromIds(ids: favorite)
        }
        
        vacanciesView.updateSubviews = { [weak self] in
            guard let self = self else { return }
            self.viewDidLayoutSubviews()
        }
        
        vacanciesView.openVacancyDetail = { [weak self] id in
            guard let self = self else { return }
            openCell(id: id)
        }
        
        vacanciesView.deleteLike = { [weak self] id, cell in
            guard let self = self else { return }
            dataManager.deleteIdFromCoreData(id: id)
            vacanciesView.favoritesData = dataManager.getIdsFromCoreData()
            if let favorite = dataManager.getIdsFromCoreData() {
                vacanciesView.dataArray = dataManager.getFavoriteDataFromIds(ids: favorite)
            }
            vacanciesView.collectionView.reloadData()
            viewDidLayoutSubviews()
        }
        
        vacanciesView.setLike = { [weak self] id, cell in
            guard let self = self else { return }
            dataManager.saveDataToCoreData(id: id)
            vacanciesView.favoritesData = dataManager.getIdsFromCoreData()
            if let favorite = dataManager.getIdsFromCoreData() {
                vacanciesView.dataArray = dataManager.getFavoriteDataFromIds(ids: favorite)
            }
            vacanciesView.collectionView.reloadData()
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
            vacanciesView.isHidden = false
            vacanciesView.favoritesData = dataManager.getIdsFromCoreData()
            if let favorite = dataManager.getIdsFromCoreData() {
                vacanciesView.dataArray = dataManager.getFavoriteDataFromIds(ids: favorite)
            }
            vacanciesView.collectionView.reloadData()
            viewDidLayoutSubviews()
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

extension FavoritesViewController : AuthenticationProtocol {
    func goToEmailConfirmation() {
        guard let navigationController = navigationController else { return }
        let viewController = CodeIntroductionElementsViewController()
        let email = authenticationView.loginView.emailTextField.text
        viewController.email = email
        navigationController.pushViewController(viewController, animated: true)
    }
}
