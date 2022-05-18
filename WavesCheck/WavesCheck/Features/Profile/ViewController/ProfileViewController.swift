//
//  ProfileViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileScreen: ProfileScreen?
    
    override func loadView() {
        profileScreen = ProfileScreen()
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileScreen?.configTextFieldDelegate(delegate: self)
        profileScreen?.delegate(delegate: self)
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


