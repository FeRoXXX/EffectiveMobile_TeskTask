//
//  ViewForSearchViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 31.03.2024.
//

import Foundation
import UIKit

class ViewForSearchViewController: UIView {
    @IBOutlet weak var fastFiltersCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vacancyCollectionView: UICollectionView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupCollectionView()
    }
    
    func setupView() {
        let bundle = loadNibFromXib()
        
        addSubview(bundle)
    }
    
    override func layoutSubviews() {
        collectionViewHeightConstraint.constant = vacancyCollectionView.contentSize.height
        if let flowLayout = vacancyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        }
    }
    
    func loadNibFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("ViewForSearchViewController", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
}

extension ViewForSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setupCollectionView() {
        fastFiltersCollectionView.delegate = self
        fastFiltersCollectionView.dataSource = self
        fastFiltersCollectionView.register(UINib(nibName: "FastFiltersCell", bundle: nil), forCellWithReuseIdentifier: "FastFiltersCell")
        vacancyCollectionView.delegate = self
        vacancyCollectionView.dataSource = self
        vacancyCollectionView.register(UINib(nibName: "VacancyCell", bundle: nil), forCellWithReuseIdentifier: "VacancyCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fastFiltersCollectionView {
            return StaticDataForFastFilters.data.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fastFiltersCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FastFiltersCell", for: indexPath) as? FastFiltersCell else { return FastFiltersCell() }
            cell.layer.cornerRadius = 8
            cell.imageView.image = StaticDataForFastFilters.data[indexPath.row].image
            cell.imageView.backgroundColor = StaticDataForFastFilters.data[indexPath.row].imageBackground
            cell.textLabel.attributedText = StaticDataForFastFilters.data[indexPath.row].text
            if let text = StaticDataForFastFilters.data[indexPath.row].secondaryText {
                cell.upInSearchLabel.isHidden = false
                cell.upInSearchLabel.attributedText = text
                cell.textLabel.lineBreakMode = .byTruncatingTail
            } else {
                cell.bottomTextLabelConstraint.isActive = false
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacancyCell", for: indexPath) as? VacancyCell else { return VacancyCell() }
            cell.layer.cornerRadius = 8
            cell.companyView.leftImage.isHidden = true
            cell.experienceView.rightImage.isHidden = true
            return cell
        }
    }
    
}
