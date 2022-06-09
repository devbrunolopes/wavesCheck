//
//  LoginViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit
import Firebase
import TransitionButton

class LoginViewController: UIViewController {

    var loginScreen: LoginScreen?
    var alert: Alert?
    var auth: Auth?
    
    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextFieldDelegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - LoginScreenProtocol

extension LoginViewController: LoginScreenProtocol {
    
    func actionSignInButton() {
        guard let login = loginScreen else {return}
        
        auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { user, error in
            
            if error != nil {
                self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.wrongData.rawValue)
            } else {
                if user == nil {
                    self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.wipeOut.rawValue)
                } else {
                    self.loginScreen?.signInButton.startAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.loginScreen?.signInButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
                            let vc: TabBarController = TabBarController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc: RegisterViewController = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionforgotPasswordButton() {
        let vc: PasswordChangeViewController = PasswordChangeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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

