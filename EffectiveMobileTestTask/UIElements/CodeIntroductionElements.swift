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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        let subview = loadViewFromXib()
        
        self.addSubview(subview)
        setupTextFields()
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("CodeIntroductionElements", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        
    }
    
    
}

extension CodeIntroductionElements : UITextFieldDelegate {
    
    func setupTextFields() {
        firstNumberTextField.delegate = self
        secondNumberTextField.delegate = self
        thirdNumberTextField.delegate = self
        fourthNumberTextField.delegate = self
        firstNumberTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("flag")
        guard textField.text != "" else { return true }
        if textField == firstNumberTextField {
            secondNumberTextField.becomeFirstResponder()
        } else if textField == secondNumberTextField {
            thirdNumberTextField.becomeFirstResponder()
        } else if textField == thirdNumberTextField {
            fourthNumberTextField.becomeFirstResponder()
        } else if textField == fourthNumberTextField {
            
        }
        return true
    }
}
