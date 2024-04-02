//
//  ViewForNumberOfViews.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import UIKit

class ViewForNumberOfViews: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 8
        setupView()
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("ViewForNumberOfViews", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
}
