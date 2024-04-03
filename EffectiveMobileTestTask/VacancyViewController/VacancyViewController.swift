//
//  VacancyViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import UIKit

class VacancyViewController: UIViewController {
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var currentViews: UIView!
    @IBOutlet weak var requestViewsLabel: UILabel!
    @IBOutlet weak var currentViewsLabel: UILabel!
    @IBOutlet weak var positionView: CompanyPositionView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var responsibilitiesLabel: UITextView!
    @IBOutlet weak var downStackView: UIStackView!
    @IBOutlet weak var textStackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var responsibilitiesLabelHeightConstraint: UITextView!
    
    var id : UUID!
    var data: Vacancy?
    var isFavorite: Bool?
    var setLikeButton: ((UUID) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        extendedLayoutIncludesOpaqueBars = false
        setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupData() {
        guard let data = data else { return }
        postLabel.text = data.title
        salaryLabel.text = data.salary.full
        experienceLabel.text = data.experience.text
        let firstLatter = (data.schedules.first?.prefix(1).capitalized ?? "") + (data.schedules.first?.dropFirst() ?? "")
        let secondLatter = (data.schedules.dropFirst().joined(separator: ", "))
        let resultJoined = firstLatter + ", " + secondLatter
        workTypeLabel.text = resultJoined
        if let text = data.appliedNumber {
            requestView.layer.cornerRadius = 8
            switch text {
            case 1:
                requestViewsLabel.text = "\(text) человек уже откликнулся"
            case 2...4:
                requestViewsLabel.text = "\(text) человека уже откликнулись"
            default:
                requestViewsLabel.text = "\(text) человек уже откликнулись"
            }
        } else {
            requestView.isHidden = true
        }
        if let text = data.lookingNumber {
            currentViews.layer.cornerRadius = 8
            switch text {
            case 1:
                requestViewsLabel.text = "\(text) человек сейчас просматривает"
            case 2...4:
                requestViewsLabel.text = "\(text) человека сейчас просматривают"
            default:
                requestViewsLabel.text = "\(text) человек сейчас просматривают"
            }
        } else {
            currentViews.isHidden = true
        }
        if let text = data.description {
            descriptionLabel.text = text
        }
        var buttonPosition = 0
        for item in data.questions {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 0, y: buttonPosition, width: 0, height: 30)
            buttonPosition += 30 + 8
            button.setTitle(item, for: .normal)
            button.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 100)
            button.setTitleColor(.white, for: .normal)
            button.sizeToFit()
            button.frame.size = CGSize(width: button.frame.width + 20, height: 30)
            button.layer.cornerRadius = button.frame.height / 2
            stackViewHeightConstraint.constant += 38
            downStackView.addSubview(button)
        }
        responsibilitiesLabel.text = data.responsibilities
        positionView.addressStringArray = data.address
        positionView.companyName = data.company
        positionView.layer.cornerRadius = 8
        positionView.setupFields()
        textStackView.sizeToFit()
        textStackView.distribution = .fillProportionally
    }

}

extension VacancyViewController {
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "Arrow"), style: .done, target: self, action: #selector(backToViewController))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        let shareButton = UIBarButtonItem(image: UIImage(named: "Share"), style: .done, target: self, action: .none)
        let eyeButton = UIBarButtonItem(image: UIImage(named: "Eye"), style: .done, target: self, action: .none)
        var likeButton = UIBarButtonItem()
        if let isFavorite = isFavorite {
            if isFavorite {
                likeButton = UIBarButtonItem(image: UIImage(named: "Like.fill"), style: .done, target: self, action: #selector(setLike))
            } else {
                likeButton = UIBarButtonItem(image: UIImage(named: "Like"), style: .done, target: self, action: #selector(setLike))
                likeButton.tintColor = .white
            }
        }
        shareButton.tintColor = .white
        eyeButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [likeButton, shareButton, eyeButton]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
    }
    
    @objc private func backToViewController() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    @objc private func setLike() {
        setLikeButton?(id)
        setupNavigationBar()
    }
}
