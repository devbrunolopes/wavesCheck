//
//  RegisterScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func backButtonAction()
    func registerButtonAction()
}

class RegisterScreen: UIView {
    
    weak private var delegate: RegisterScreenProtocol?
    
    func delegate(delegate: RegisterScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: K.Images.back.rawValue), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapbackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.Images.waves.rawValue)
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
        textField.placeholder = K.TextFields.name.rawValue
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
        textField.placeholder = K.TextFields.email.rawValue
        textField.textColor = .darkGray
        textField.autocapitalizationType = .none
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
        textField.placeholder = K.TextFields.password.rawValue
        textField.textColor = .darkGray
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle(K.Buttons.register.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackGround()
        addSubView()
        setUpConstraints()
        enableButton(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - @OBJC Functions
    
    @objc private func didTapbackButton() {
        delegate?.backButtonAction()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.registerButtonAction()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        userNameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    public func validateTextField() {
        if userNameTextField.text != K.emptyString.rawValue && emailTextField.text != K.emptyString.rawValue && passwordTextField.text != K.emptyString.rawValue {
            enableButton(true)
        } else {
            enableButton(false)
        }
    }
    
    public func getEmail() -> String {
        return emailTextField.text ?? K.emptyString.rawValue
    }
    
    public func getPassword() -> String {
        return passwordTextField.text ?? K.emptyString.rawValue
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(backButton)
        addSubview(logoAppImageView)
        addSubview(userNameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    private func enableButton(_ enable: Bool) {
        if enable {
            registerButton.isEnabled = true
            registerButton.setTitleColor(.white, for: .normal)
        } else {
            registerButton.isEnabled = false
            registerButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            logoAppImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            logoAppImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            logoAppImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
            
            userNameTextField.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
