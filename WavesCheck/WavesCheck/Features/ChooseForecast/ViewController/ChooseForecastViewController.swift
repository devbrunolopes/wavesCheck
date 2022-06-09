//
//  ChooseForecastViewController.swift
//  LoginViewCode
//
//  Created by Bruno Lopes on 07/06/22.
//

import UIKit

class ChooseForecastViewController: UIViewController {
    var chooseForecastScreen: ChooseForecastScreen?
    
    var states: [StatesModel] = [
        StatesModel(state: "São Paulo", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Santa Catarina", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Rio de Janeiro", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Espírito Santo", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Paraná", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Bahia", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Sergipe", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Alagoas", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Pernambuco", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Paraíba", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Rio Grande do Norte", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Ceará", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Piauí", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Maranhão", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"]),
        StatesModel(state: "Pará", opened: false, beaches: ["Guarujá", "Santos", "Maresias", "Camburi", "Ubatuba"])
    ]
    
    var state: [State] = [
        State(state: "São Paulo", opened: false),
        State(state: "Rio de Janeiro", opened: false),
        State(state: "Santa Catarina", opened: false),
        State(state: "Espírito Santo", opened: false),
        State(state: "Paraná", opened: false),
        State(state: "Bahia", opened: false),
        State(state: "Sergipe", opened: false),
        State(state: "Alagoas", opened: false),
        State(state: "Pernambuco", opened: false),
        State(state: "Paraíba", opened: false),
        State(state: "Rio Grande do Norte", opened: false),
        State(state: "Ceará", opened: false),
        State(state: "Piauí", opened: false),
        State(state: "Maranhão", opened: false),
        State(state: "Pará", opened: false)
    ]
    
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

extension ChooseForecastViewController: ChooseForecastHeaderViewProtocol {
    func showRowsAction(indexPath: IndexPath, tableView: UITableView) {
        openCloseSections(indexPath: indexPath, tableView: tableView)
    }
}

//MARK: - TableView Delegate e DataSource

extension ChooseForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return state.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state[section].opened == true {
            return 5
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseForecastTableViewCell.identifier, for: indexPath) as? ChooseForecastTableViewCell
        cell?.setUpCell(state: states[indexPath.row].beaches[indexPath.row])
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChooseForecastHeaderView.identifier) as? ChooseForecastHeaderView
        header?.delegate(delegate: self)
        header?.setUpCell(state: state[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openCloseSections(indexPath: indexPath, tableView: tableView)
        print(indexPath)
    }
    
    func openCloseSections(indexPath:IndexPath, tableView: UITableView) {
        if state[indexPath.section].opened == true {
            state[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            state[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}
