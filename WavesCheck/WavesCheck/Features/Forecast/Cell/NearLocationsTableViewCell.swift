//
//  NearLocationsTableViewCell.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class NearLocationsTableViewCell: UITableViewCell {

    static let identifier: String = "NearLocationsTableViewCell"
    
    lazy var nearLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Praia da Macumba"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(17)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.didTapGoButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubView()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OBJC Functions
    
    @objc private func didTapGoButton(){
        
    }
    
    //MARK: - Public Functions
    
    public func setUpCell(nearLocation: NearLocation) {
        self.nearLocationLabel.text = nearLocation.locationName
    }
    
    //MARK: - Private Functions
    
    private func addSubView() {
        self.contentView.addSubview(self.nearLocationLabel)
        self.contentView.addSubview(self.goButton)
    }
 
    private func configConstraints() {
        NSLayoutConstraint.activate([

            self.nearLocationLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.nearLocationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.nearLocationLabel.widthAnchor.constraint(equalToConstant: 500),
            
            self.goButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.goButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            
        ])
    }

}
