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
        StatesModel(state: "Rio de Janeiro", opened: false, beaches: ["Grumari", "Prainha", "Praia da Macumba", "Itacoatiara", "Canto do Recreio"]),
        StatesModel(state: "Santa Catarina", opened: false, beaches: ["Florianópolis", "Imbituba", "Garopaba", "Bombinhas", "Balneário Cambuiriú"]),
        StatesModel(state: "Espírito Santo", opened: false, beaches: ["Regência", "Jacaraípe", "Solemar", "Barrote", "Amigão"]),
        StatesModel(state: "Paraná", opened: false, beaches: ["Guaratuba", "Matinhos", "Ilha do Mel", "Pontal do Paraná", "Paraguaios"]),
        StatesModel(state: "Bahia", opened: false, beaches: ["Prainha", "Farol da Barra", "Stella", "Vilas do Atlântico", "Pescador"]),
        StatesModel(state: "Pernambuco", opened: false, beaches: ["Cacimba do Padre", "Praia da Conceição", "Praia do Boldró", "Praia do Meio", "Praia do Bode"]),
        StatesModel(state: "Rio Grande do Norte", opened: false, beaches: ["Baía Formosa", "Pontal", "Pipa", "Artistas", "Escadaria"])
    ]
    
    var state: [State] = [
        State(state: "São Paulo", opened: false),
        State(state: "Rio de Janeiro", opened: false),
        State(state: "Santa Catarina", opened: false),
        State(state: "Espírito Santo", opened: false),
        State(state: "Paraná", opened: false),
        State(state: "Bahia", opened: false),
        State(state: "Pernambuco", opened: false),
        State(state: "Rio Grande do Norte", opened: false)
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
        cell?.setUpCell(state: states[indexPath.section].beaches[indexPath.row])
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
