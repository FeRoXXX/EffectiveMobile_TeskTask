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
    @IBOutlet weak var mainView: UIView!
    var dataArray : JsonRequestData?
    
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
        vacancyCollectionView.isScrollEnabled = false
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
        guard let dataArray = dataArray else { return 0 }
        if collectionView == fastFiltersCollectionView {
            return dataArray.offers.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fastFiltersCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FastFiltersCell", for: indexPath) as? FastFiltersCell else { return FastFiltersCell() }
            cell.layer.cornerRadius = 8
            if indexPath.row < StaticDataForFastFilters.data.count {
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
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacancyCell", for: indexPath) as? VacancyCell else { return VacancyCell() }
            guard let dataArray = dataArray else { return VacancyCell() }
            cell.layer.cornerRadius = 8
            cell.companyView.leftImage.isHidden = true
            cell.experienceView.rightImage.isHidden = true
            if let numberViews = dataArray.vacancies[indexPath.row].lookingNumber {
                switch numberViews {
                case 2:
                    cell.numberViews.text = "Сейчас просматривает \(numberViews) человека"
                default:
                    cell.numberViews.text = "Сейчас просматривает \(numberViews) человек"
                }
            } else {
                cell.numberViews.isHidden = true
            }
            cell.postLaber.text = dataArray.vacancies[indexPath.row].title
            if let salary = dataArray.vacancies[indexPath.row].salary.short {
                cell.salaryLabel.text = salary
            } else {
                cell.salaryLabel.isHidden = true
            }
            cell.cityLabel.text = dataArray.vacancies[indexPath.row].address.town
            cell.companyView.textLabel.text = dataArray.vacancies[indexPath.row].company
            cell.experienceView.textLabel.text = dataArray.vacancies[indexPath.row].experience.previewText
            let dateFormater = DateFormatter()
            dateFormater.locale = Locale(identifier: "ru_RU")
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.date(from: dataArray.vacancies[indexPath.row].publishedDate)
            if let date = date {
                let dayMonthFormatter = DateFormatter()
                dayMonthFormatter.locale = Locale(identifier: "ru_RU")
                dayMonthFormatter.dateFormat = "d MMMM"
                    
                let dayMonthString = dayMonthFormatter.string(from: date)
                cell.dateOfPublishLabel.text = "Опубликовано \(dayMonthString)"
            }
            if dataArray.vacancies[indexPath.row].isFavorite {
                cell.likeImage.image = UIImage(named: "Like.fill")
            } else {
                cell.likeImage.image = UIImage(named: "Like")
            }
            return cell
        }
    }
    
}
