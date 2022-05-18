//
//  RegisterViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    var alert: Alert?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextFieldDelegate(delegate: self)
        alert = Alert(controller: self)
    }
}

//MARK: - RegisterScreenProtocol

extension RegisterViewController: RegisterScreenProtocol {
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func registerButtonAction() {
        alert?.configAlert(title: "Izaaa", message: "Cadastro realizado com sucesso")
    }
}

//MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerScreen?.validateTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerScreen?.userNameTextField {
            registerScreen?.emailTextField.becomeFirstResponder()
        } else if textField == registerScreen?.emailTextField {
            registerScreen?.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

