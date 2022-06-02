//
//  InfoScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

protocol InfoViewDelegate: AnyObject {
    func backButtonAction()
}

class InfoScreen: UIView {

    private weak var delegate: InfoViewDelegate?
    
    func delegate(delegate: InfoViewDelegate) {
        self.delegate = delegate
    }
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        return view
    }()
    
    lazy var wavesSizeIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "waveIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var wavesSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.numberOfLines = 0
        label.text = " - Tamanho das ondas"
        return label
    }()
    
    lazy var periodIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "clock")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = " - Período entre as séries"
        return label
    }()
    
    lazy var swellDirectionIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "location.circle")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var swellDirectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = " - Direção do swell"
        return label
    }()
    
    lazy var windIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "wind")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(15)
        label.numberOfLines = 0
        label.text = " - Velocidade e direção do vento"
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Voltar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.setTitleColor(.white , for: .normal)
        button.addTarget(self, action: #selector(self.didTapbackButton), for: .touchUpInside)
        button.layer.cornerRadius = 7
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
    
    //MARK: - OBJC Functions
    
    @objc func didTapbackButton() {
        delegate?.backButtonAction()
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
    }
    
    private func addSubView() {
        addSubview(infoView)
        infoView.addSubview(wavesSizeIconImageView)
        infoView.addSubview(wavesSizeLabel)
        infoView.addSubview(periodIconImageView)
        infoView.addSubview(periodLabel)
        infoView.addSubview(swellDirectionIconImageView)
        infoView.addSubview(swellDirectionLabel)
        infoView.addSubview(windIconImageView)
        infoView.addSubview(windLabel)
        infoView.addSubview(backButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            infoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 220),
            infoView.widthAnchor.constraint(equalToConstant: 300),
            
            wavesSizeIconImageView.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            wavesSizeIconImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            wavesSizeIconImageView.heightAnchor.constraint(equalToConstant: 30),
            wavesSizeIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            wavesSizeLabel.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            wavesSizeLabel.leadingAnchor.constraint(equalTo: wavesSizeIconImageView.trailingAnchor, constant: 10),
            wavesSizeLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            
            periodIconImageView.topAnchor.constraint(equalTo: wavesSizeIconImageView.bottomAnchor, constant: 10),
            periodIconImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            periodIconImageView.heightAnchor.constraint(equalToConstant: 30),
            periodIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            periodLabel.centerYAnchor.constraint(equalTo: periodIconImageView.centerYAnchor),
            periodLabel.leadingAnchor.constraint(equalTo: periodIconImageView.trailingAnchor, constant: 10),
            periodLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            
            swellDirectionIconImageView.topAnchor.constraint(equalTo: periodIconImageView.bottomAnchor, constant: 10),
            swellDirectionIconImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            swellDirectionIconImageView.heightAnchor.constraint(equalToConstant: 30),
            swellDirectionIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            swellDirectionLabel.centerYAnchor.constraint(equalTo: swellDirectionIconImageView.centerYAnchor),
            swellDirectionLabel.leadingAnchor.constraint(equalTo: swellDirectionIconImageView.trailingAnchor, constant: 10),
            swellDirectionLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            
            windIconImageView.topAnchor.constraint(equalTo: swellDirectionIconImageView.bottomAnchor, constant: 10),
            windIconImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            windIconImageView.heightAnchor.constraint(equalToConstant: 30),
            windIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            windLabel.centerYAnchor.constraint(equalTo: windIconImageView.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windIconImageView.trailingAnchor, constant: 10),
            windLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            
            backButton.topAnchor.constraint(equalTo: windIconImageView.bottomAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            backButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
