//
//  NearLocationsTableViewCell.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

protocol NearLocationsTableViewCellProtocol: AnyObject {
    func goButtonAction()
}

class NearLocationsTableViewCell: UITableViewCell {

    static let identifier: String = "NearLocationsTableViewCell"
    
    weak private var delegate: NearLocationsTableViewCellProtocol?
    
    func delegate(delegate: NearLocationsTableViewCellProtocol) {
        self.delegate = delegate
    }
    
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
        button.addTarget(self, action: #selector(didTapGoButton), for: .touchUpInside)
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
        delegate?.goButtonAction()
    }
    
    //MARK: - Public Functions
    
    public func setUpCell(nearLocation: NearLocation) {
        nearLocationLabel.text = nearLocation.locationName
    }
    
    //MARK: - Private Functions
    
    private func addSubView() {
        contentView.addSubview(nearLocationLabel)
        contentView.addSubview(goButton)
    }
 
    private func configConstraints() {
        NSLayoutConstraint.activate([

            nearLocationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            nearLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nearLocationLabel.widthAnchor.constraint(equalToConstant: 500),
            
            goButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            goButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
            
        ])
    }

}
