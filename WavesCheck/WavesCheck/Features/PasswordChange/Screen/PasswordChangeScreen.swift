//
//  PasswordChangeScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

protocol PasswordChangeScreenProtocol: AnyObject {
    func backButtonAction()
    func changePasswordButtonAction()
}

class PasswordChangeScreen: UIView {
    
    weak private var delegate: PasswordChangeScreenProtocol?
    
    func delegate(delegate: PasswordChangeScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapbackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "duckSurfer")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Use seu email cadastrado para recuperar a senha:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
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
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitle("Enviar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapChangePasswordButton), for: .touchUpInside)
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
    
    //MARK: - @OBJC Functions
    
    @objc func didTapbackButton() {
        delegate?.backButtonAction()
    }
    
    @objc func didTapChangePasswordButton() {
        delegate?.changePasswordButtonAction()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
    }
    
    public func validateTextField() {
        if emailTextField.text != "" {
            enableButton(true)
        } else {
            enableButton(false)
        }
    }
    
    //MARK: - Private Funcitons
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(backButton)
        addSubview(logoAppImageView)
        addSubview(messageLabel)
        addSubview(emailTextField)
        addSubview(changePasswordButton)
    }
    
    private func enableButton(_ enable: Bool) {
        if enable {
            changePasswordButton.isEnabled = true
            changePasswordButton.setTitleColor(.white, for: .normal)
        } else {
            changePasswordButton.isEnabled = false
            changePasswordButton.setTitleColor(.lightGray, for: .normal)
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
            logoAppImageView.heightAnchor.constraint(equalToConstant: 200),
            
            messageLabel.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 50),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            changePasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            changePasswordButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            changePasswordButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

