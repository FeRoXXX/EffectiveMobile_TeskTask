//
//  fastFiltersCell.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 29.03.2024.
//

import UIKit

class FastFiltersCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var upInSearchLabel: UILabel!
    @IBOutlet weak var bottomTextLabelConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }

}
