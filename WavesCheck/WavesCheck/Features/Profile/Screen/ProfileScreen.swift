//
//  ProfileScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 18/05/22.
//

import UIKit

protocol ProfileScreenProtocol: AnyObject {
    func editPictureButtonAction()
    func saveButtonAction()
    func logOutButtonAction()
}

class ProfileScreen: UIView {
    
    weak private var delegate: ProfileScreenProtocol?
    
    func delegate(delegate: ProfileScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    lazy var editPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Editar foto", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapEditPictureButton), for: .touchUpInside)
        return button
    }()
    
    lazy var personalDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dados Pessoais"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome:"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sexo:"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Sair", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackGround()
        addSubView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Objc Functions
    
    @objc private func didTapEditPictureButton() {
        delegate?.editPictureButtonAction()
    }
    
    @objc private func didTapSaveButton() {
        delegate?.saveButtonAction()
    }
    
    @objc private func didTapLogOutButton() {
        delegate?.logOutButtonAction()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        birthdayTextField.delegate = delegate
        genderTextField.delegate = delegate
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        self.backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(userImageView)
        addSubview(personalDataLabel)
        addSubview(editPictureButton)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(birthdayLabel)
        addSubview(birthdayTextField)
        addSubview(genderLabel)
        addSubview(genderTextField)
        addSubview(saveButton)
        addSubview(logOutButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
                    
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            
            editPictureButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            editPictureButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            editPictureButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            editPictureButton.heightAnchor.constraint(equalToConstant: 30),
            
            personalDataLabel.topAnchor.constraint(equalTo: editPictureButton.bottomAnchor, constant: 20),
            personalDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            personalDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            birthdayLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            birthdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 5),
            birthdayTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            birthdayTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            genderLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 15),
            genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            genderTextField.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            genderTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            saveButton.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: 15),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            logOutButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
            logOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            logOutButton.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }

}
