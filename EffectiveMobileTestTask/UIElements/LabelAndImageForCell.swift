//
//  LabelAndImageForCell.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 31.03.2024.
//

import Foundation
import UIKit

class LabelAndImageForCell: UIView {
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        resizeToFill(image: UIImage(named: "Experience")!, imageView: leftImage)
        resizeToFill(image: UIImage(named: "Part.time")!, imageView: rightImage)
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("LabelAndImageForCell", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
    private func resizeToFill(image: UIImage, imageView: UIImageView) {
        let imageSize = image.size
        imageView.frame.size = imageSize
    }
}
