//
//  ForecastViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

class ForecastViewController: UIViewController {

    var forecastScreen: ForecastScreen?
    let viewModel: ForecastViewModel = ForecastViewModel()
    
    override func loadView() {
        forecastScreen = ForecastScreen()
        view = forecastScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastScreen?.delegate(delegate: self)
        viewModel.delegate(delegate: self)
        viewModel.getForecastRequest()
        configTableView()
    }
    
    private func configTableView() {
        forecastScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        forecastScreen?.tableView.reloadData()
        print("VAMOOOO \(viewModel.forecast)")
    }
}

//MARK: - ForecastScreenProtocol

extension ForecastViewController: ForecastScreenProtocol {
    
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func infoButtonAction() {
        let vc: InfoViewController = InfoViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as? ForecastTableViewCell
//        cell?.setUpCell(report: reports[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - ViewModelDelegate

extension ForecastViewController: ForecastViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
        }
    }
    
    func error() {
        print("Deu ruim FDP")
    }
}
