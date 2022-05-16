//
//  ForecastViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class ForecastViewController: UIViewController {

    var forecastScreen: ForecastScreen?
    
    var nearLocation: [NearLocation] = [
        NearLocation(locationName: "Praia da Macumba"),
        NearLocation(locationName: "Canto do Recreio"),
        NearLocation(locationName: "Prainha")
    ]
    
    override func loadView() {
        forecastScreen = ForecastScreen()
        view = forecastScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

//MARK: - TableView Delegate e DataSource

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NearLocationsTableViewCell.identifier, for: indexPath) as? NearLocationsTableViewCell
        cell?.setUpCell(nearLocation: self.nearLocation[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Locais próximos"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }

}
