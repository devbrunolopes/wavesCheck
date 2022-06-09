//
//  ForecastScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import MapKit

protocol CheckForecastScreenProtocol: AnyObject {
    func selfLocationButtonAction()
    func searchButtonAction()
    func navigateButtonAction()
}

class CheckForecastScreen: UIView {
    
    weak private var delegate: CheckForecastScreenProtocol?
    
    public func delegate(delegate: CheckForecastScreenProtocol) {
        self.delegate = delegate
    }

    lazy var selfLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: K.Images.selfLocation.rawValue), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSelfLocationButton), for: .touchUpInside)
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        textField.layer.cornerRadius = 7
        textField.borderStyle = .roundedRect
        textField.placeholder = K.TextFields.search.rawValue
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: K.Images.magnifyingglass.rawValue), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
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
    
    lazy var navigateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(K.Buttons.openInMaps.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.didTapNavigateButton), for: .touchUpInside)
        return button
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
        delegate?.selfLocationButtonAction()
    }
    
    @objc private func didTapSearchButton(){
        delegate?.searchButtonAction()
    }
    
    @objc private func didTapNavigateButton(){
        delegate?.navigateButtonAction()
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
        addSubview(self.navigateButton)
        addSubview(self.tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            userWelcomeStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            userWelcomeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userWelcomeStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: userWelcomeStackView.bottomAnchor, constant: 5),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            mapView.heightAnchor.constraint(equalToConstant: 350),
            
            navigateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            navigateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            navigateButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -30),
            navigateButton.heightAnchor.constraint(equalToConstant: 35),
            
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor,constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: 0)
            
        ])
    }
}
