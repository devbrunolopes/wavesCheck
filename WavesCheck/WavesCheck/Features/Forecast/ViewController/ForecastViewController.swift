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
    var alert: Alert?
    
    override func loadView() {
        forecastScreen = ForecastScreen()
        view = forecastScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastScreen?.delegate(delegate: self)
        viewModel.delegate(delegate: self)
        viewModel.getForecastRequest()
    }
    
    private func configTableView() {
        forecastScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        forecastScreen?.tableView.reloadData()
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
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as? ForecastTableViewCell
        cell?.setUpCell(forecast: viewModel.forecast[indexPath.row], date: viewModel.dates[indexPath.row])
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
        alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.wipeOut.rawValue, completion: nil)
    }
}
