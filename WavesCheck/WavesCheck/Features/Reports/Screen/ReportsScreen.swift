//
//  ReportsScreen.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

protocol ReportsScreenProtocol: AnyObject {
    func addReportAction()
    func getData()
}

class ReportsScreen: UIView {
    
    weak private var delegate: ReportsScreenProtocol?
    
    func delegate(delegate: ReportsScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var reportsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reports"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return label
    }()
    
    lazy var addReportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapAddReport), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.register(ReportsTableViewCell.self, forCellReuseIdentifier: ReportsTableViewCell.identifier)
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
    
    //MARK: - OBJC Functions
    
    @objc private func didTapAddReport() {
        delegate?.addReportAction()
        delegate?.getData()
    }
    
    //MARK: - Public Functions
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(reportsLabel)
        addSubview(addReportButton)
        addSubview(tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            reportsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            reportsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            addReportButton.centerYAnchor.constraint(equalTo: reportsLabel.centerYAnchor),
            addReportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: reportsLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }

}
