//
//  ProfileViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import Firebase
import FirebaseStorage
import AlamofireImage

class ProfileViewController: UIViewController {

    var profileScreen: ProfileScreen?
    var auth: Auth?
    var alert: Alert?
    let pickerController = UIImagePickerController()
    var viewModel = ProfileViewModel()
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference()
    var user: [User] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }
    
    func initialConfig() {
        profileScreen?.nameTextField.text = user[0].name
        profileScreen?.birthdayTextField.text = user[0].birthday
        profileScreen?.genderTextField.text = user[0].gender
        let url = URL(string: user[0].image) ?? URL(fileURLWithPath: "")
        profileScreen?.userImageView.af.setImage(withURL: url)
    }
    
    private func addPicture() {
        pickerController.allowsEditing = false
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    private func saveUserData(name: String, birthday: String, gender: String, image: String) {
        let dataPath = "users/\(UUID().uuidString)"
        let docRef = firestore.document(dataPath)
        docRef.setData([
            "name": name,
            "birthday": birthday,
            "gender": gender,
            "image": image
        ])
    }
    
    private func saveUserImage() {
        guard let image = profileScreen?.userImageView.image?.jpegData(compressionQuality: 0.8) else {return}
        
        let imagePath = "userImages/\(UUID().uuidString).jpg"

        let imageRef = storage.child(imagePath)
        
        imageRef.putData(image, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                imageRef.downloadURL { url, error in
                    if error == nil{
                        if let urlImagem = url?.absoluteString{
                            self.firestore.collection("images").document().setData([
                                "url": urlImagem
                            ])
                            self.completionReport(with: urlImagem)
                        }
                    }else{
                        self.completionReport()
                    }
                }
            }else{
                self.completionReport()
            }
        }
    }
    
    private func completionReport(with url: String = ""){
        saveUserData(name: profileScreen?.nameTextField.text ?? "", birthday: profileScreen?.birthdayTextField.text ?? "", gender: profileScreen?.genderTextField.text ?? "", image: url)
    }
    
    func getUserData() {
        firestore.collection("users").getDocuments { snapshot, error in
            
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.user = snapshot.documents.map { document in
                            return User(id: document.documentID,
                                        name: document["name"] as? String ?? "",
                                        birthday: document["birthday"] as? String ?? "",
                                        gender: document["gender"] as? String ?? "",
                                        image: document["image"] as? String ?? "")
                        }
                        self.initialConfig()
                    }
                }
                
            } else {
                self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.wipeOut.rawValue, completion: nil)
            }
        }
    }
    
}

//MARK: - ProfileScreenProtocol

extension ProfileViewController: ProfileScreenProtocol {
    func editPictureButtonAction() {
        addPicture()
    }
    
    func saveButtonAction() {
        saveUserImage()
    }
    
    func logOutButtonAction() {
        do {
            try auth?.signOut()
            let vc: LoginViewController = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
        } catch _ {
            alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.wipeOut.rawValue)
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
        if textField == profileScreen?.nameTextField {
            profileScreen?.birthdayTextField.becomeFirstResponder()
        } else if textField == profileScreen?.birthdayTextField {
            profileScreen?.genderTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
