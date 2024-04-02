//
//  ViewForFavoriteViewController.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import UIKit

class ViewForFavoriteViewController: UIView {
    @IBOutlet weak var numberOfVacancy: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstrain: NSLayoutConstraint!
    
    var data : [Vacancy]?
    var updateSubviews : (() -> Void)?
    var openVacancyDetail : ((UUID) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupCollectionView()
    }
    
    private func setupView() {
        let bundle = loadViewFromXib()
        
        addSubview(bundle)
    }
    
    private func setupLabel() {
        guard let data = data else {
            numberOfVacancy.text = "Список пуст"
            return
        }
        switch data.count {
        case 0:
            numberOfVacancy.text = "Список пуст"
        case 1:
            numberOfVacancy.text = "\(data.count) вакансия"
        case 2...4:
            numberOfVacancy.text = "\(data.count) вакансии"
        default:
            numberOfVacancy.text = "\(data.count) вакансий"
        }
    }
    
    override func layoutSubviews() {
        collectionView.isScrollEnabled = false
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        updateSubviews?()
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("ViewForFavoriteViewController", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
}

extension ViewForFavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "VacancyCell", bundle: nil), forCellWithReuseIdentifier: "VacancyCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacancyCell", for: indexPath) as? VacancyCell,
              let data = data else { return VacancyCell() }
        cell.layer.cornerRadius = 8
        cell.companyView.leftImage.isHidden = true
        cell.experienceView.rightImage.isHidden = true
        if let numberViews = data[indexPath.row].lookingNumber {
            switch numberViews {
            case 2:
                cell.numberViews.text = "Сейчас просматривает \(numberViews) человека"
            default:
                cell.numberViews.text = "Сейчас просматривает \(numberViews) человек"
            }
        } else {
            cell.numberViews.isHidden = true
        }
        cell.postLaber.text = data[indexPath.row].title
        if let salary = data[indexPath.row].salary.short {
            cell.salaryLabel.text = salary
        } else {
            cell.salaryLabel.isHidden = true
        }
        cell.cityLabel.text = data[indexPath.row].address.town
        cell.companyView.textLabel.text = data[indexPath.row].company
        cell.experienceView.textLabel.text = data[indexPath.row].experience.previewText
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: data[indexPath.row].publishedDate)
        if let date = date {
            let dayMonthFormatter = DateFormatter()
            dayMonthFormatter.locale = Locale(identifier: "ru_RU")
            dayMonthFormatter.dateFormat = "d MMMM"
                
            let dayMonthString = dayMonthFormatter.string(from: date)
            cell.dateOfPublishLabel.text = "Опубликовано \(dayMonthString)"
        }
        if data[indexPath.row].isFavorite {
            cell.likeImage.image = UIImage(named: "Like.fill")
        } else {
            cell.likeImage.image = UIImage(named: "Like")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = data else { return }
        openVacancyDetail?(data[indexPath.row].id)
    }
}
