//
//  PasswordChangeViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit
import Firebase

class PasswordChangeViewController: UIViewController {

    var passwordChangeScreen: PasswordChangeScreen?
    var alert: Alert?
    var auth: Auth?
    
    override func loadView() {
        passwordChangeScreen = PasswordChangeScreen()
        view = passwordChangeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordChangeScreen?.delegate(delegate: self)
        passwordChangeScreen?.configTextFieldDelegate(delegate: self)
        alert = Alert(controller: self)
        auth = Auth.auth()
    }
}

//MARK: - PasswordChangeScreenProtocol

extension PasswordChangeViewController: PasswordChangeScreenProtocol {
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func changePasswordButtonAction() {
        
        auth?.sendPasswordReset(withEmail: passwordChangeScreen?.emailTextField.text ?? K.emptyString.rawValue, completion: { error in
            if let error = error {
                self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: error.localizedDescription)
            }
            
            self.alert?.configAlert(title: K.Alerts.iza.rawValue, message: K.Alerts.sentEmail.rawValue)
            
        })
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

