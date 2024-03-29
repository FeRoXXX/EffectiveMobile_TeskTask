//
//  EmailConfirmationElements.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 28.03.2024.
//

import UIKit

class CodeIntroductionElements: UIView {
    
    @IBOutlet weak var sendToEmailLabel: UILabel!
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var thirdNumberTextField: UITextField!
    @IBOutlet weak var fourthNumberTextField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setButtonStyle()
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
        setupTextFields()
        acceptButton.isEnabled = false
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("CodeIntroductionElements", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        
    }
    
    
}

extension CodeIntroductionElements : UITextFieldDelegate {
    
    private func setupTextFields() {
        firstNumberTextField.delegate = self
        secondNumberTextField.delegate = self
        thirdNumberTextField.delegate = self
        fourthNumberTextField.delegate = self
        firstNumberTextField.becomeFirstResponder()
    }
    
    private func setButtonStyle() {
        if firstNumberTextField.text == "" || secondNumberTextField.text == "" || thirdNumberTextField.text == "" || fourthNumberTextField.text == "" {
            acceptButton.isEnabled = false
            acceptButton.backgroundColor = UIColor(red: 0, green: 66/255, blue: 125/255, alpha: 1)
            acceptButton.setTitleColor(UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1), for: .disabled)
            acceptButton.layer.cornerRadius = 8
        } else {
            acceptButton.isEnabled = true
            acceptButton.backgroundColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
            
            acceptButton.layer.cornerRadius = 8
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        if string.isEmpty {
            textField.text = string
            if textField == fourthNumberTextField {
                setButtonStyle()
                thirdNumberTextField.becomeFirstResponder()
            } else if textField == thirdNumberTextField {
                setButtonStyle()
                secondNumberTextField.becomeFirstResponder()
            } else if textField == secondNumberTextField {
                setButtonStyle()
                firstNumberTextField.becomeFirstResponder()
            }
            return false
        } else {
            if textField.text != "" {
                if textField == firstNumberTextField {
                    secondNumberTextField.becomeFirstResponder()
                } else if textField == secondNumberTextField {
                    thirdNumberTextField.becomeFirstResponder()
                } else if textField == thirdNumberTextField {
                    fourthNumberTextField.becomeFirstResponder()
                } else if textField == fourthNumberTextField {
                    return false
                }
                return true
            } else {
                textField.text = string
                if textField == firstNumberTextField {
                    secondNumberTextField.becomeFirstResponder()
                } else if textField == secondNumberTextField {
                    thirdNumberTextField.becomeFirstResponder()
                } else if textField == thirdNumberTextField {
                    fourthNumberTextField.becomeFirstResponder()
                } else if textField == fourthNumberTextField {
                    setButtonStyle()
                }
                return false
            }
        }
    }
}
