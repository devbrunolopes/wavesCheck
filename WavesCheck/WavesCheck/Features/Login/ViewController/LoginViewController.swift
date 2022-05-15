//
//  LoginViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    var loginScreen: LoginScreen?
    
    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextFieldDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - LoginScreenProtocol

extension LoginViewController: LoginScreenProtocol {
    
    func actionSignInButton() {
//        let vc: TabBarController = TabBarController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionRegisterButton() {
//        let vc: SignUpViewController = SignUpViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionforgotPasswordButton() {
//        let vc: PasswordChangeViewController = PasswordChangeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        loginScreen?.validateTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginScreen?.emailTextField {
            loginScreen?.passwordTextField.becomeFirstResponder()
        } else if textField == loginScreen?.passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

