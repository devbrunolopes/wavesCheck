//
//  ReportsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class ReportsViewController: UIViewController {

    var reportsScreen: ReportsScreen?
    
    var report: [Report] = [
        Report(locationName: "Canto do Recreio, RJ", image: UIImage(named: "surfer") ?? UIImage(), size: "Tamanho: 0.5+", condition: "Condição: Tem uma vala"),
        Report(locationName: "Grumari, RJ", image: UIImage(named: "surf") ?? UIImage(), size: "Tamanho: 0.3", condition: "Condição: Tá osso"),
        Report(locationName: "Praia do Tombo, SP", image: UIImage(named: "surf1") ?? UIImage(), size: "Tamanho: 1.5+", condition: "Condição: Altas ondas"),
        Report(locationName: "Maresias, SP", image: UIImage(named: "surf2") ?? UIImage(), size: "Tamanho: 0.5", condition: "Condição: Vale a queda"),
        Report(locationName: "Stella Maris, BA", image: UIImage(named: "surf3") ?? UIImage(), size: "Tamanho: 1.5", condition: "Condição: Mexido demais"),
        Report(locationName: "Pitangueiras, SP", image: UIImage(named: "surf4") ?? UIImage(), size: "Tamanho: 1.0", condition: "Condição: Tem uma vala"),
    ]
    
    override func loadView() {
        reportsScreen = ReportsScreen()
        view = self.reportsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportsTableViewCell.identifier) as? ReportsTableViewCell
        cell?.setUpCell(report: report[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}

