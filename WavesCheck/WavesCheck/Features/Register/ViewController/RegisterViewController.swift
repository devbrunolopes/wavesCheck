//
//  RegisterViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    var alert: Alert?
    var auth: Auth?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextFieldDelegate(delegate: self)
        alert = Alert(controller: self)
        auth = Auth.auth()
    }
}

//MARK: - RegisterScreenProtocol

extension RegisterViewController: RegisterScreenProtocol {
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func registerButtonAction() {
        guard let register = registerScreen else {return}
        
        auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { success, error in
            
            if error != nil {
                print(error ?? "Erro ao cadastrar")
            } else {
                let vc: ProfileViewController = ProfileViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
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

