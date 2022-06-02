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
    let pickerController = UIImagePickerController()
    
    override func loadView() {
        profileScreen = ProfileScreen()
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileScreen?.configTextFieldDelegate(delegate: self)
        profileScreen?.delegate(delegate: self)
        pickerController.delegate = self
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    private func addPicture() {
        pickerController.allowsEditing = false
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
}

//MARK: - ProfileScreenProtocol

extension ProfileViewController: ProfileScreenProtocol {
    func editPictureButtonAction() {
        addPicture()
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

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileScreen?.userImageView.image = pickedImage
            profileScreen?.userImageView.clipsToBounds = true
            profileScreen?.userImageView.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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


