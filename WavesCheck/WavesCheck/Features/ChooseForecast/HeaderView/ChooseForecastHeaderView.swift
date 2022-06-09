//
//  ChooseForecastHeaderView.swift
//  LoginViewCode
//
//  Created by Bruno Lopes on 08/06/22.
//

import UIKit

class ChooseForecastHeaderView: UITableViewHeaderFooterView {

    static let identifier: String = K.CellIdentifier.chooseForecastHeaderView.rawValue
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Baleia"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: K.Images.chevronDown.rawValue), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return button
    }()
    
    //MARK: - Initializers
      
    var indexPath = IndexPath()
    var tableView = UITableView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubView()
        self.configConstraints()
        backgroundColor = .lightGray
        goButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Functions
    
    public func setUpCell(state: State) {
        self.stateLabel.text = state.state
    }
    
    //MARK: - Private Functions
    
    private func addSubView() {
        self.addSubview(self.stateLabel)
        self.addSubview(self.goButton)
    }
 
    private func configConstraints() {
        NSLayoutConstraint.activate([

            self.stateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.stateLabel.widthAnchor.constraint(equalToConstant: 500),
            
            self.goButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.goButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            
        ])
    }
}
