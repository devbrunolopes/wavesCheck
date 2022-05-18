//
//  LoginScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func actionforgotPasswordButton()
    func actionSignInButton()
    func actionRegisterButton()
}

class LoginScreen: UIView {
    
    weak private var delegate: LoginScreenProtocol?
    
    func delegate(delegate: LoginScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "WavesCheck"
        return label
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "waves")
        image.contentMode = .scaleAspectFit
        return image
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
        textField.placeholder = "Digite a sua senha"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueceu a senha?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapforgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta? Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackGround()
        addSubView()
        setUpConstraints()
        enableButton(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OBJC Functions
    
    @objc private func didTapforgotPasswordButton() {
        delegate?.actionforgotPasswordButton()
    }
    
    @objc private func didTapSignInButton() {
        delegate?.actionSignInButton()
    }
    
    @objc private func didTapSignUpButton() {
        delegate?.actionRegisterButton()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    public func validateTextField() {
        if emailTextField.text != "" && passwordTextField.text != "" {
            enableButton(true)
        } else {
            enableButton(false)
        }
    }
    
    private func enableButton(_ enable: Bool) {
        if enable {
            signInButton.isEnabled = true
            signInButton.setTitleColor(.white, for: .normal)
        } else {
            signInButton.isEnabled = false
            signInButton.setTitleColor(.lightGray, for: .normal)
        }
    }

    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(loginLabel)
        addSubview(logoAppImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgotPasswordButton)
        addSubview(signInButton)
        addSubview(registerButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            logoAppImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            logoAppImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
            
            emailTextField.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            registerButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            registerButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
            
        ])
    }

}
