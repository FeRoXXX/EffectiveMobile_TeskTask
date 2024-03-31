//
//  ViewForVacancy.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 30.03.2024.
//

import Foundation
import UIKit

class ViewForVacancy : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        let bundle = loadNibFromXib()
        
        addSubview(bundle)
    }
    
    func loadNibFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("ViewForVacancy", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
}
