//
//  ReportsTableViewCell.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import FirebaseStorage
import Firebase
import AlamofireImage

class ReportsTableViewCell: UITableViewCell {

    static let identifier: String = K.CellIdentifier.reportsTableViewCell.rawValue
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Praia do Tombo(Guarujá, SP)"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var locationImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "surfer")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tamanho: 1.0 +"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Condição: Valendo o surf"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        setUpConstraints()
        initialConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Functions
    
    public func setUpCell(report: Report) {
        locationLabel.text = "Local: \(report.nameLocation)"
        sizeLabel.text = "Tamanho: \(report.wavesSize)"
        conditionLabel.text = "Condição: \(report.surfCondition)"
         
    }

    //MARK: - Private Functions
    
    private func addSubView() {
        contentView.addSubview(locationLabel)
        contentView.addSubview(locationImageView)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(conditionLabel)
    }
    
    private func initialConfig() {
        selectionStyle = .none
        backgroundColor = .white
        clipsToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = CGColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            locationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            locationImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            locationImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 200),
            
            sizeLabel.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 10),
            sizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            conditionLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),
            conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
        ])
    }
}
