//
//  LoginView.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var nextStep : (() -> Void)?
    var loginWithPassword : (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("LoginView", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
    @IBAction func loginWithPasswordClicked(_ sender: Any) {
        loginWithPassword?()
    }
    
    @IBAction func toNextStepClicked(_ sender: Any) {
        nextStep?()
    }
    
}
