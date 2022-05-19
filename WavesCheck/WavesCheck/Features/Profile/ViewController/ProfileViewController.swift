//
//  ProfileViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    var profileScreen: ProfileScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        profileScreen = ProfileScreen()
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileScreen?.configTextFieldDelegate(delegate: self)
        profileScreen?.delegate(delegate: self)
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
}

//MARK: - ProfileScreenProtocol

extension ProfileViewController: ProfileScreenProtocol {
    func editPictureButtonAction() {
        
    }
    
    func changePasswordButtonAction() {
        
    }
    
    func saveButtonAction() {
        
    }
    
    func logOutButtonAction() {
        do {
            try auth?.signOut()
            let vc: LoginViewController = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
        } catch let signOutError {
            alert?.configAlert(title: "Ops", message: signOutError.localizedDescription)
        }
    }
}

//MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


