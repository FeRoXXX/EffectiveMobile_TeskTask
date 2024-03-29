//
//  FindEmployee.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class FindEmployee: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        self.layer.cornerRadius = 8
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("FindEmployee", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
}
