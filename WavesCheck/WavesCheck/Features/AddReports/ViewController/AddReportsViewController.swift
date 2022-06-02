//
//  AddReportsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

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
            guard let data = snapshot?.data(), error == nil else {return}
            print(data)
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
            "surfImage": image
        ])
    }
    
    private func saveImageReport() {
        // turn image into data
        guard let image = addReportsScreen?.locationImage.image?.jpegData(compressionQuality: 0.8) else {return}
        
        // specify file path and name
        let imagePath = "reportImages/\(UUID().uuidString).jpg"
        imageURL = imagePath
        let imageRef = storage.child(imagePath)
        
        // upload that data
        let uploadTask = imageRef.putData(image, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                self.firestore.collection("images").document().setData([
                    "url": imagePath
                ])
            }
        }
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
        saveReport(nameLocation: addReportsScreen?.locationTextField.text ?? "", wavesSize: addReportsScreen?.wavesSizeTextField.text ?? "", surfCondition: addReportsScreen?.surfConditionTextField.text ?? "", image: imageURL)
//        delegate?.retrievePicturesToReports()
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddReportsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addReportsScreen?.locationImage.image = pickedImage
            addReportsScreen?.locationImage.layer.cornerRadius = addReportsScreen?.locationImage.frame.size.height ?? 0 / 2
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
