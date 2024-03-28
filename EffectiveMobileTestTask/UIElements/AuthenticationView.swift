//
//  AuthenticationView.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class AuthenticationView: UIView {
    
    @IBOutlet weak var loginView: LoginView!
    @IBOutlet weak var findEmployee: FindEmployee!
    
    var nextButtonClicked : (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        
        loginView.nextStep = { [weak self] in
            guard let self = self else { return }
            nextButtonClicked?()
        }
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("AuthenticationView", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
}
