//
//  ForecastScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import MapKit

class ForecastScreen: UIView {

    lazy var selfLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.didTapSelfLocationButton), for: .touchUpInside)
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        textField.layer.cornerRadius = 7
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.didTapSearchButton), for: .touchUpInside)
        return button
    }()
    
    lazy var userWelcomeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [selfLocationButton, searchTextField, searchButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(NearLocationsTableViewCell.self, forCellReuseIdentifier: NearLocationsTableViewCell.identifier)
        return tableView
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
    
    //MARK: - @OBJC Functions
    
    @objc private func didTapSelfLocationButton(){
    }
    
    @objc private func didTapSearchButton(){
    }
    
    //MARK: - Public Functions
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
    }
    
    private func addSubView() {
        addSubview(self.userWelcomeStackView)
        addSubview(self.mapView)
        addSubview(self.tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            userWelcomeStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            userWelcomeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userWelcomeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: self.userWelcomeStackView.bottomAnchor, constant: 5),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mapView.heightAnchor.constraint(equalToConstant: 350),
            
            tableView.topAnchor.constraint(equalTo: self.mapView.bottomAnchor,constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0)
            
        ])
    }

}
