//
//  AddReportsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class AddReportsViewController: UIViewController {

    var addReportsScreen: AddReportsScreen?
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference()
    let pickerController = UIImagePickerController()
    var imageURL: String = ""
  
    override func loadView() {
        self.addReportsScreen = AddReportsScreen()
        self.view = self.addReportsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReportsScreen?.delegate(delegate: self)
        
        pickerController.delegate = self
        
        let docRef = firestore.document("wavesCheck/reports")
        docRef.getDocument { snapshot, error in
            guard let _ = snapshot?.data(), error == nil else {return}
        }
    }
    
    private func addPicture() {
        pickerController.allowsEditing = false
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    private func saveReport(nameLocation: String, wavesSize: String, surfCondition: String, image: String) {
        let dataPath = "reports/\(UUID().uuidString)"
        let docRef = firestore.document(dataPath)
        docRef.setData([
            "nameLocation": nameLocation,
            "wavesSize": wavesSize,
            "surfCondition": surfCondition,
            "surfImage": image,
            "reportDate": Date().timeIntervalSince1970
        ])
    }
    
    private func saveImageReport() {
        guard let image = addReportsScreen?.locationImage.image?.jpegData(compressionQuality: 0.8) else {return}
        
        let imagePath = "reportImages/\(UUID().uuidString).jpg"

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
    
    private func completionReport(with url:String = ""){
        self.saveReport(nameLocation: self.addReportsScreen?.locationTextField.text ?? "", wavesSize: self.addReportsScreen?.wavesSizeTextField.text ?? "", surfCondition: self.addReportsScreen?.surfConditionTextField.text ?? "", image: url)
    }
}

//MARK: - AddReportsScreenProtocol

extension AddReportsViewController: AddReportsScreenProtocol {
    func addPicButtonAction() {
        addPicture()
    }
    
    func addReportButtonAction() {
        print(#function)
        saveImageReport()
        dismiss(animated: true)
    }
    
    func modalLineGestureAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddReportsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addReportsScreen?.locationImage.image = pickedImage
            addReportsScreen?.locationImage.clipsToBounds = true
            addReportsScreen?.locationImage.contentMode = .scaleAspectFill
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate

extension AddReportsViewController: UITextFieldDelegate {
    
}
