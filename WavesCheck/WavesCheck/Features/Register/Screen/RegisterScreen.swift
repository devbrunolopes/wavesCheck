//
//  RegisterScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class RegisterScreen: UIView {

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.didTapbackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "waves")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.placeholder = "Digite seu nome"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.placeholder = "Digite seu email"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.placeholder = "Digite a sua senha"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.addSubView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - @OBJC Functions
    
    @objc private func didTapbackButton() {
//        self.delegate?.actionBackButton()
    }
    
    @objc private func didTapSignUpButton() {
//        self.delegate?.actionSignUpButton()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.userNameTextField.delegate = delegate
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    public func validateTextField() {
        if userNameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
            self.enableButton(true)
        } else {
            self.enableButton(false)
        }
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        self.backgroundColor = .white
    }
    
    private func addSubView() {
        self.addSubview(self.backButton)
        self.addSubview(self.logoAppImageView)
        self.addSubview(self.userNameTextField)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.signUpButton)
    }
    
    private func enableButton(_ enable: Bool) {
        if enable {
            self.signUpButton.isEnabled = true
            self.signUpButton.setTitleColor(.white, for: .normal)
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.backButton.heightAnchor.constraint(equalToConstant: 40),
            self.backButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.logoAppImageView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 20),
            self.logoAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.logoAppImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.userNameTextField.topAnchor.constraint(equalTo: self.logoAppImageView.bottomAnchor, constant: 50),
            self.userNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.userNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.userNameTextField.bottomAnchor, constant: 20),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.userNameTextField.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.userNameTextField.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.userNameTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.userNameTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.signUpButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 40),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
