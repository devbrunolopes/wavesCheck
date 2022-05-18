//
//  PasswordChangeViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {

    var passwordChangeScreen: PasswordChangeScreen?
    var alert: Alert?
    
    override func loadView() {
        passwordChangeScreen = PasswordChangeScreen()
        view = passwordChangeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeScreen?.delegate(delegate: self)
        passwordChangeScreen?.configTextFieldDelegate(delegate: self)
        alert = Alert(controller: self)
    }
}

//MARK: - PasswordChangeScreenProtocol

extension PasswordChangeViewController: PasswordChangeScreenProtocol {
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func changePasswordButtonAction() {
        alert?.configAlert(title: "Izzaaaa", message: "Email enviado com sucesso, verifique sua caixa de email/spam em instantes!")
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

