//
//  LoginView.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var underTextFieldLabel: UILabel!
    
    var nextStep : (() -> Void)?
    var loginWithPassword : (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupTextField()
        setButtonStyle()
        self.layer.cornerRadius = 8
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
        if !checkEmail() {
            badEmail()
        } else {
            nextStep?()
        }
    }
    
}

extension LoginView : UITextFieldDelegate {
    
    private func setupTextField() {
        emailTextField.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта или телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1)])
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named: "Cross"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        emailTextField.rightView = clearButton
        emailTextField.rightViewMode = .whileEditing
        var imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 100, height: 100))
        imageView = UIImageView(image: UIImage(named: "Response"))
        imageView.sizeToFit()
        emailTextField.leftView = imageView
        emailTextField.leftViewMode = .unlessEditing
    }
    
    private func checkEmail() -> Bool {
        guard let text = emailTextField.text else { return false }
        if text.isValidEmail {
            return true
        } else {
            return false
        }
    }
    
    private func setButtonStyle() {
        if emailTextField.text == "" {
            acceptButton.isUserInteractionEnabled = false
            acceptButton.backgroundColor = UIColor(red: 0, green: 66/255, blue: 125/255, alpha: 1)
            acceptButton.tintColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)
            acceptButton.layer.cornerRadius = 8
        } else {
            acceptButton.isUserInteractionEnabled = true
            acceptButton.backgroundColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
            acceptButton.tintColor = .white
            acceptButton.layer.cornerRadius = 8
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        emailTextField.layer.borderWidth = 0
        emailTextField.textColor = .white
        underTextFieldLabel.isHidden = true
        if let text = emailTextField.text {
            emailTextField.text = text + string
        } else {
            emailTextField.text = string
        }
        
        if string == "" {
            return true
        }
        setButtonStyle()
        return false
    }
    
    @objc private func clearText() {
        emailTextField.text = ""
        emailTextField.layer.borderWidth = 0
        emailTextField.textColor = .white
        underTextFieldLabel.isHidden = true
        setButtonStyle()
    }
    
    private func badEmail() {
        emailTextField.layer.borderColor = UIColor.red.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 8
        emailTextField.textColor = .red
        underTextFieldLabel.isHidden = false
    }
    
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
