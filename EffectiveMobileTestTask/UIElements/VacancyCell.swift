//
//  VacancyCell.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 31.03.2024.
//

import UIKit

class VacancyCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var numberViews: UILabel!
    @IBOutlet weak var postLaber: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var companyView: LabelAndImageForCell!
    @IBOutlet weak var experienceView: LabelAndImageForCell!
    @IBOutlet weak var dateOfPublishLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var requestButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
        postLaber.sizeToFit()
    }

}
