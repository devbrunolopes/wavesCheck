//
//  ChooseForecastScreen.swift
//  LoginViewCode
//
//  Created by Bruno Lopes on 07/06/22.
//

import UIKit
import MapKit

class ChooseForecastScreen: UIView {
    
    lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Previsão das Ondas"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(ChooseForecastTableViewCell.self, forCellReuseIdentifier: ChooseForecastTableViewCell.identifier)
        tableView.register(ChooseForecastHeaderView.self, forHeaderFooterViewReuseIdentifier: ChooseForecastHeaderView.identifier)
        return tableView
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
    
    //MARK: - Public Functions
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        self.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
    }
    
    private func addSubView() {
        self.addSubview(forecastLabel)
        self.addSubview(self.tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            self.forecastLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.forecastLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.forecastLabel.bottomAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}
