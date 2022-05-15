//
//  PasswordChangeViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {

    var passwordChangeScreen: PasswordChangeScreen?
    
    override func loadView() {
        passwordChangeScreen = PasswordChangeScreen()
        view = passwordChangeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeScreen?.delegate(delegate: self)
        passwordChangeScreen?.configTextFieldDelegate(delegate: self)
    }
}

//MARK: - PasswordChangeScreenProtocol

extension PasswordChangeViewController: PasswordChangeScreenProtocol {
    func backButtonAction() {
        
    }
    
    func changePasswordButtonAction() {
        
    }
}

//MARK: - UITextFieldDelegate

extension PasswordChangeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordChangeScreen?.validateTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

