//
//  AddReportsScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

protocol AddReportsScreenProtocol: AnyObject {
    func addPicButtonAction()
    func addReportButtonAction()
}

class AddReportsScreen: UIView {
    
    weak private var delegate: AddReportsScreenProtocol?
    
    func delegate(delegate: AddReportsScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var modalLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        view.layer.cornerRadius = 7
        return view
    }()
    
    lazy var addReportLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicionar um novo report"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return view
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Local:"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.placeholder = "Ex: Maresias"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var wavesSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tamanho:"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var wavesSizeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.placeholder = "Ex: 1.0+"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var surfConditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Condição:"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var surfConditionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.placeholder = "Ex: Vale o surf"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var locationImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "camera.fill")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.layer.cornerRadius = 50
        image.contentMode = .scaleAspectFit
        return image
    }()
       
    lazy var addPicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar foto", for: .normal)
        button.setTitleColor(UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(self.didTapAddPicButton), for: .touchUpInside)
        return button
    }()
    
    lazy var addReportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar Report", for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(self.didTapAddReportButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OBJC Functions
    
    @objc private func didTapAddPicButton() {
        delegate?.addPicButtonAction()
    }
    
    @objc private func didTapAddReportButton() {
        delegate?.addReportButtonAction()
    }
    
    //MARK: - Public Functions
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        locationTextField.delegate = delegate
        wavesSizeTextField.delegate = delegate
        surfConditionTextField.delegate = delegate
    }
 
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func configSuperView() {
        addSubview(modalLineView)
        addSubview(addReportLabel)
        addSubview(lineView)
        addSubview(locationLabel)
        addSubview(locationTextField)
        addSubview(wavesSizeLabel)
        addSubview(wavesSizeTextField)
        addSubview(surfConditionLabel)
        addSubview(surfConditionTextField)
        addSubview(locationImage)
        addSubview(addPicButton)
        addSubview(addReportButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            modalLineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            modalLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            modalLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            modalLineView.heightAnchor.constraint(equalToConstant: 2),
            
            addReportLabel.topAnchor.constraint(equalTo: modalLineView.bottomAnchor, constant: 20),
            addReportLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addReportLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            lineView.topAnchor.constraint(equalTo: addReportLabel.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            locationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            locationTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            locationTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            wavesSizeLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 10),
            wavesSizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            wavesSizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            wavesSizeTextField.topAnchor.constraint(equalTo: wavesSizeLabel.bottomAnchor, constant: 5),
            wavesSizeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            wavesSizeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            surfConditionLabel.topAnchor.constraint(equalTo: wavesSizeTextField.bottomAnchor, constant: 10),
            surfConditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            surfConditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            surfConditionTextField.topAnchor.constraint(equalTo: surfConditionLabel.bottomAnchor, constant: 5),
            surfConditionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            surfConditionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            locationImage.topAnchor.constraint(equalTo: surfConditionTextField.bottomAnchor, constant: 10),
            locationImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationImage.heightAnchor.constraint(equalToConstant: 100),
            locationImage.widthAnchor.constraint(equalToConstant: 100),
            
            addPicButton.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 10),
            addPicButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addPicButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addPicButton.heightAnchor.constraint(equalToConstant: 30),
            
            addReportButton.topAnchor.constraint(equalTo: addPicButton.bottomAnchor, constant: 15),
            addReportButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addReportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addReportButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

