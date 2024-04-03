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
    
    var dataArray : [Vacancy]?
    var favoritesData : [CoreDataIds]?
    var updateSubviews : (() -> Void)?
    var openVacancyDetail : ((UUID) -> Void)?
    var deleteLike : ((UUID, UICollectionViewCell) -> Void)?
    var setLike: ((UUID, UICollectionViewCell) -> Void)?
    
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
        guard let favoritesData = favoritesData else {
            numberOfVacancy.text = "Список пуст"
            return
        }
        switch favoritesData.count {
        case 0:
            numberOfVacancy.text = "Список пуст"
        case 1:
            numberOfVacancy.text = "\(favoritesData.count) вакансия"
        case 2...4:
            numberOfVacancy.text = "\(favoritesData.count) вакансии"
        default:
            numberOfVacancy.text = "\(favoritesData.count) вакансий"
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
        guard let favoritesData = favoritesData else { return 0 }
        setupLabel()
        return favoritesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacancyCell", for: indexPath) as? VacancyCell else { return VacancyCell() }
        guard let dataArray = dataArray,
              let favoritesData = favoritesData else { return VacancyCell() }
        cell.layer.cornerRadius = 8
        cell.companyView.leftImage.isHidden = true
        cell.experienceView.rightImage.isHidden = true
        if let numberViews = dataArray[indexPath.row].lookingNumber {
            cell.numberViews.isHidden = false
            switch numberViews {
            case 2...4:
                cell.numberViews.text = "Сейчас просматривает \(numberViews) человека"
            default:
                cell.numberViews.text = "Сейчас просматривает \(numberViews) человек"
            }
        } else {
            cell.numberViews.isHidden = true
        }
        cell.postLaber.text = dataArray[indexPath.row].title
        if let salary = dataArray[indexPath.row].salary.short {
            cell.salaryLabel.text = salary
            cell.salaryLabel.isHidden = false
        } else {
            cell.salaryLabel.isHidden = true
        }
        cell.cityLabel.text = dataArray[indexPath.row].address.town
        cell.companyView.textLabel.text = dataArray[indexPath.row].company
        cell.experienceView.textLabel.text = dataArray[indexPath.row].experience.previewText
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: dataArray[indexPath.row].publishedDate)
        if let date = date {
            let dayMonthFormatter = DateFormatter()
            dayMonthFormatter.locale = Locale(identifier: "ru_RU")
            dayMonthFormatter.dateFormat = "d MMMM"
                
            let dayMonthString = dayMonthFormatter.string(from: date)
            cell.dateOfPublishLabel.text = "Опубликовано \(dayMonthString)"
        }
        cell.id = dataArray[indexPath.row].id
        if favoritesData.contains(where: { $0.id == dataArray[indexPath.row].id }) {
            cell.likeImage.image = UIImage(named: "Like.fill")
        } else {
            cell.likeImage.image = UIImage(named: "Like")
        }
        cell.likeButtonClicked = { [weak self] id in
            guard let self = self else { return }
            if favoritesData.contains(where: { $0.id == id }) {
                deleteLike?(id, cell)
            } else {
                setLike?(id, cell)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataArray = dataArray else { return }
        openVacancyDetail?(dataArray[indexPath.row].id)
    }
}
