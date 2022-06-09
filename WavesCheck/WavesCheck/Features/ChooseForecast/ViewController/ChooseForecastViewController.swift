//
//  ChooseForecastViewController.swift
//  LoginViewCode
//
//  Created by Bruno Lopes on 07/06/22.
//

import UIKit

class ChooseForecastViewController: UIViewController {
    var chooseForecastScreen: ChooseForecastScreen?
    
    var viewModel: ChooseForecastViewModel = ChooseForecastViewModel()
    
    override func loadView() {
        chooseForecastScreen = ChooseForecastScreen()
        view = chooseForecastScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseForecastScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - ChooseForecastTableViewCellProtocol

extension ChooseForecastViewController :ChooseForecastTableViewCellProtocol {
    func goButtonAction() {
        let vc: ForecastViewController = ForecastViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView Delegate e DataSource

extension ChooseForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.state.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseForecastTableViewCell.identifier, for: indexPath) as? ChooseForecastTableViewCell
        cell?.setUpCell(state: viewModel.statesBeaches[indexPath.section].beaches[indexPath.row])
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChooseForecastHeaderView.identifier) as? ChooseForecastHeaderView
        header?.setUpCell(state: viewModel.state[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
}
